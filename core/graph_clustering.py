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
        
        p1_out = {
            "strategies": [
                {
                    "id": "strategy_1_branch_aware",
                    "description": "Deterministic branch-aware topological clustering that respects physical dependencies and separates parallel construction tasks.",
                    "batches": batches
                }
            ]
        }
        
        p2_out = {
            "selected": "strategy_1_branch_aware",
            "reason": "Graph engine determined this exact deterministic sequence."
        }
        
        return p1_out, p2_out
