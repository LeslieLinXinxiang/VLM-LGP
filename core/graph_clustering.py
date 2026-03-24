import json

class BranchAwareClustering:
    def __init__(self, phase1_json):
        self.phase1_json = phase1_json
        self.nodes = {}  # id -> { "id": id, "object": name, "supporters": [...], "supported": [...] }
        self._parse_graph()

    def _parse_graph(self):
        """Parse 'objects' array format or 'G=(V,E)' direct format into a unified graph."""
        if "V" in self.phase1_json and "E" in self.phase1_json:
            vertices = self.phase1_json["V"]
            edges = self.phase1_json["E"]
        elif "objects" in self.phase1_json:
            # Need to extract V and E
            from core.graph_adapter import build_graph_from_phase1
            G = build_graph_from_phase1(self.phase1_json)
            vertices = G["V"]
            edges = G["E"]
        else:
            raise ValueError("Unsupported phase1_json format. Expected 'objects' array or 'G=(V,E)' structure.")

        for v in vertices:
            self.nodes[v["id"]] = {
                "id": v["id"],
                "object": v["object"],
                "supporters": [],
                "supported": [],
                "layer": -1,
                "branch": None
            }

        for e in edges:
            u, v = e["from"], e["to"]
            pos = e.get("position", None)
            self.nodes[v]["supporters"].append({"id": u, "position": pos})
            self.nodes[u]["supported"].append(v)

    def _compute_layers(self):
        """Topological grouping by layer."""
        changed = True
        for node_id in self.nodes:
            if not self.nodes[node_id]["supporters"]:
                self.nodes[node_id]["layer"] = 0

        while changed:
            changed = False
            for node_id, data in self.nodes.items():
                if data["layer"] != -1:
                    continue
                unresolved = False
                max_sup_layer = -1
                for sup in data["supporters"]:
                    sup_layer = self.nodes[sup["id"]]["layer"]
                    if sup_layer == -1:
                        unresolved = True
                        break
                    max_sup_layer = max(max_sup_layer, sup_layer)
                
                if not unresolved and max_sup_layer != -1:
                    data["layer"] = max_sup_layer + 1
                    changed = True

    def _compute_branches(self):
        """Assign branches based on root positions to separate left/right building sequences."""
        for node_id, data in self.nodes.items():
            if data["layer"] == 1:
                # Direct child of base (layer 0)
                for sup in data["supporters"]:
                    if self.nodes[sup["id"]]["layer"] == 0 and sup.get("position"):
                        data["branch"] = sup["position"]
                        break
                if not data["branch"]:
                     data["branch"] = f"branch_{node_id}" # fallback

        # Propagate branch up to higher layers
        for layer in range(2, 100):
            for node_id, data in self.nodes.items():
                if data["layer"] == layer:
                    branches = set()
                    for sup in data["supporters"]:
                        sup_branch = self.nodes[sup["id"]]["branch"]
                        if sup_branch:
                            branches.add(sup_branch)
                    if len(branches) == 1:
                        data["branch"] = list(branches)[0]
                    elif len(branches) > 1:
                        data["branch"] = "bridge"

    def _cluster(self):
        self._compute_layers()
        self._compute_branches()

        placed = set()
        for n_id, data in self.nodes.items():
            if data["layer"] == 0:
                placed.add(n_id)

        batches = []
        max_batch_size = 2

        while len(placed) < len(self.nodes):
            placeable = []
            for n_id, data in self.nodes.items():
                if n_id not in placed:
                    if all(sup["id"] in placed for sup in data["supporters"]):
                        placeable.append(n_id)
            
            if not placeable:
                raise ValueError("Graph has cyclic dependencies or unreachable nodes!")

            by_branch = {}
            for n_id in placeable:
                br = self.nodes[n_id]["branch"]
                by_branch.setdefault(br, []).append(n_id)
            
            added_this_round = False
            # Sort branches arbitrarily but deterministically for consistent output
            for br in sorted(by_branch.keys(), key=lambda x: str(x)):
                items = sorted(by_branch[br])
                while items:
                    batch = items[:max_batch_size]
                    batches.append(batch)
                    for b in batch:
                        placed.add(b)
                    items = items[max_batch_size:]
                    added_this_round = True
            
            if not added_this_round:
                break

        return batches

    def generate_optimal_strategy(self):
        """Returns p1_out, p2_out matching legacy VLM JSON requirements."""
        batches = self._cluster()
        order = [node_id for batch in batches for node_id in batch]
        
        p1_out = {
            "strategies": [
                {
                    "id": "strategy_1_branch_aware",
                    "description": "Deterministic branch-aware topological clustering that respects physical dependencies and separates parallel construction tasks.",
                    "order": order,
                    "batches": batches
                }
            ]
        }
        
        p2_out = {
            "selected": "strategy_1_branch_aware",
            "reason": "Graph engine determined this exact deterministic sequence."
        }
        
        return p1_out, p2_out


class BranchAwareLayerCuttingClustering(BranchAwareClustering):
    def __init__(self, phase1_json, max_batch_size=2):
        self.max_batch_size = max_batch_size
        super().__init__(phase1_json)

    def _ensure_graph_annotations(self):
        self._compute_layers()
        self._compute_branches()

    def _collect_branch_groups(self):
        self._ensure_graph_annotations()

        groups = {}
        for node_id, data in self.nodes.items():
            if node_id == 0:
                continue
            branch = data["branch"] or f"singleton_{node_id}"
            groups.setdefault(branch, []).append(node_id)

        for branch_nodes in groups.values():
            branch_nodes.sort(key=lambda n_id: (self.nodes[n_id]["layer"], n_id))

        return groups

    def _build_branch_dependency_graph(self, branch_groups):
        node_to_branch = {}
        for branch_name, branch_nodes in branch_groups.items():
            for node_id in branch_nodes:
                node_to_branch[node_id] = branch_name

        dependency_graph = {branch_name: set() for branch_name in branch_groups}
        for branch_name, branch_nodes in branch_groups.items():
            for node_id in branch_nodes:
                for supporter in self.nodes[node_id]["supporters"]:
                    supporter_id = supporter["id"]
                    if supporter_id == 0:
                        continue
                    supporter_branch = node_to_branch.get(supporter_id)
                    if supporter_branch and supporter_branch != branch_name:
                        dependency_graph[branch_name].add(supporter_branch)

        return dependency_graph

    def _branch_priority(self, branch_name, branch_groups):
        branch_nodes = branch_groups[branch_name]
        min_layer = min(self.nodes[node_id]["layer"] for node_id in branch_nodes)
        min_node_id = min(branch_nodes)
        is_bridge = 1 if branch_name == "bridge" else 0
        return (len(self._branch_dependencies[branch_name]), is_bridge, min_layer, min_node_id, str(branch_name))

    def _order_branches(self, branch_groups):
        self._branch_dependencies = self._build_branch_dependency_graph(branch_groups)

        ordered = []
        resolved = set()
        while len(resolved) < len(branch_groups):
            ready = []
            for branch_name, dependencies in self._branch_dependencies.items():
                if branch_name in resolved:
                    continue
                if dependencies.issubset(resolved):
                    ready.append(branch_name)

            if not ready:
                raise ValueError("Branch dependency graph contains a cycle or unresolved dependency.")

            ready.sort(key=lambda name: self._branch_priority(name, branch_groups))
            next_branch = ready[0]
            ordered.append(next_branch)
            resolved.add(next_branch)

        return ordered

    def _compute_local_layers(self, branch_nodes):
        branch_node_set = set(branch_nodes)
        local_layers = {}

        for node_id in branch_nodes:
            in_branch_supporters = [
                supporter["id"]
                for supporter in self.nodes[node_id]["supporters"]
                if supporter["id"] in branch_node_set
            ]
            if not in_branch_supporters:
                local_layers[node_id] = 0

        changed = True
        while changed:
            changed = False
            for node_id in branch_nodes:
                if node_id in local_layers:
                    continue

                in_branch_supporters = [
                    supporter["id"]
                    for supporter in self.nodes[node_id]["supporters"]
                    if supporter["id"] in branch_node_set
                ]
                if all(supporter_id in local_layers for supporter_id in in_branch_supporters):
                    local_layers[node_id] = 1 + max(local_layers[supporter_id] for supporter_id in in_branch_supporters)
                    changed = True

        if len(local_layers) != len(branch_nodes):
            missing = sorted(set(branch_nodes) - set(local_layers))
            raise ValueError(f"Failed to compute local layers for branch nodes: {missing}")

        return local_layers

    def _cut_branch_with_layers(self, branch_nodes):
        local_layers = self._compute_local_layers(branch_nodes)
        branch_node_set = set(branch_nodes)

        by_layer = {}
        for node_id in branch_nodes:
            by_layer.setdefault(local_layers[node_id], []).append(node_id)

        batches = []
        for layer in sorted(by_layer.keys()):
            role_groups = {}
            for node_id in sorted(by_layer[layer]):
                in_branch_supporters = tuple(
                    sorted(
                        supporter["id"]
                        for supporter in self.nodes[node_id]["supporters"]
                        if supporter["id"] in branch_node_set
                    )
                )
                role_groups.setdefault(in_branch_supporters, []).append(node_id)

            for role_key in sorted(role_groups.keys()):
                items = role_groups[role_key]
                while items:
                    batch = items[:self.max_batch_size]
                    batches.append(batch)
                    items = items[self.max_batch_size:]

        return batches

    def generate_decomposition_report(self):
        branch_groups = self._collect_branch_groups()
        ordered_branches = self._order_branches(branch_groups)

        branch_batches = []
        global_batches = []
        for branch_name in ordered_branches:
            nodes = branch_groups[branch_name]
            batches = self._cut_branch_with_layers(nodes)
            branch_batches.append(
                {
                    "branch": branch_name,
                    "nodes": nodes,
                    "batches": batches,
                }
            )
            global_batches.extend(batches)

        return {
            "branch_groups": [
                {"branch": item["branch"], "nodes": item["nodes"]}
                for item in branch_batches
            ],
            "branch_batches": branch_batches,
            "global_batches": global_batches,
        }

    def generate_optimal_strategy(self):
        """
        Returns p1_out, p2_out with the same schema as the legacy graph clustering
        entry, so Phase2 downstream code can switch between implementations without
        changing JSON consumers.
        """
        report = self.generate_decomposition_report()
        batches = report["global_batches"]
        order = [node_id for batch in batches for node_id in batch]

        p1_out = {
            "strategies": [
                {
                    "id": "strategy_1_branch_layer_cutting",
                    "description": (
                        "Controlled branch grouping plus hierarchy-aware batch cutting "
                        "that preserves support dependencies while exposing a two-stage "
                        "decomposition interface."
                    ),
                    "order": order,
                    "batches": batches,
                    "metadata": {
                        "algorithm": "BranchAwareLayerCuttingClustering",
                        "branch_groups": report["branch_groups"],
                    },
                }
            ]
        }

        p2_out = {
            "selected": "strategy_1_branch_layer_cutting",
            "reason": (
                "Default Phase2 clustering switched to the controlled two-stage "
                "decomposition engine; legacy branch-aware clustering remains "
                "available as a fallback."
            ),
        }

        return p1_out, p2_out
