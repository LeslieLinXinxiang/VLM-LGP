import json
from typing import Dict, List, Tuple

import numpy as np

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


class KMeansBranchClustering(BranchAwareClustering):
    """
    Deterministic k-means clustering on Phase1 target-graph features.

    Design goals for TASK-020 v1:
    1) Input is only target-graph (Phase1 JSON).
    2) k-means clustering is deterministic via fixed seed.
    3) Output strategy must remain dependency-safe for solver execution.
    4) Output schema must stay compatible with existing Prompt1/Prompt2 consumers.
    """

    def __init__(self, phase1_json, k: int = 2, seed: int = 7, max_iter: int = 100, max_batch_size: int = 2):
        self.k = max(1, int(k))
        self.seed = int(seed)
        self.max_iter = max(1, int(max_iter))
        self.max_batch_size = max(1, int(max_batch_size))
        super().__init__(phase1_json)

    def _node_ids(self) -> List[int]:
        """Return target object ids (exclude table id 0)."""
        return sorted([node_id for node_id in self.nodes if node_id != 0])

    def _safe_layer(self, node_id: int) -> int:
        layer = self.nodes[node_id].get("layer", -1)
        return 0 if layer == -1 else int(layer)

    def _build_feature_matrix(self) -> Tuple[List[int], np.ndarray, List[str]]:
        """
        Build node feature vectors strictly from target-graph topology.

        Feature set (v1):
        - layer
        - in_degree
        - out_degree
        - supporter_layer_mean
        - is_multi_support
        - pos_left_count
        - pos_right_count
        - pos_unknown_count
        """
        self._compute_layers()

        node_ids = self._node_ids()
        rows: List[List[float]] = []
        for node_id in node_ids:
            data = self.nodes[node_id]
            supporters = data["supporters"]
            supported = data["supported"]

            layer = float(self._safe_layer(node_id))
            in_degree = float(len(supporters))
            out_degree = float(len(supported))

            supporter_layers = []
            pos_left_count = 0.0
            pos_right_count = 0.0
            pos_unknown_count = 0.0

            for sup in supporters:
                sup_id = sup["id"]
                supporter_layers.append(float(self._safe_layer(sup_id)))
                pos = sup.get("position", None)
                if pos == "left":
                    pos_left_count += 1.0
                elif pos == "right":
                    pos_right_count += 1.0
                else:
                    pos_unknown_count += 1.0

            supporter_layer_mean = float(np.mean(supporter_layers)) if supporter_layers else 0.0
            is_multi_support = 1.0 if len(supporters) > 1 else 0.0

            rows.append(
                [
                    layer,
                    in_degree,
                    out_degree,
                    supporter_layer_mean,
                    is_multi_support,
                    pos_left_count,
                    pos_right_count,
                    pos_unknown_count,
                ]
            )

        feature_names = [
            "layer",
            "in_degree",
            "out_degree",
            "supporter_layer_mean",
            "is_multi_support",
            "pos_left_count",
            "pos_right_count",
            "pos_unknown_count",
        ]
        return node_ids, np.array(rows, dtype=float), feature_names

    @staticmethod
    def _zscore(x: np.ndarray) -> np.ndarray:
        """Column-wise z-score normalization with zero-variance protection."""
        mean = np.mean(x, axis=0)
        std = np.std(x, axis=0)
        std = np.where(std < 1e-12, 1.0, std)
        return (x - mean) / std

    def _kmeans_plus_plus_init(self, x: np.ndarray, k: int, rng: np.random.Generator) -> np.ndarray:
        """
        Deterministic k-means++ initialization.

        Steps:
        1) pick first center uniformly
        2) pick next center with probability proportional to squared distance
        """
        n = x.shape[0]
        centers = []
        first_idx = int(rng.integers(0, n))
        centers.append(x[first_idx])

        for _ in range(1, k):
            d2 = np.min(
                np.stack([np.sum((x - c) ** 2, axis=1) for c in centers], axis=1),
                axis=1,
            )
            total = float(np.sum(d2))
            if total < 1e-12:
                centers.append(x[int(rng.integers(0, n))])
                continue
            probs = d2 / total
            idx = int(rng.choice(np.arange(n), p=probs))
            centers.append(x[idx])

        return np.array(centers, dtype=float)

    def _run_kmeans(self, x: np.ndarray) -> Tuple[np.ndarray, np.ndarray, float]:
        """
        Run deterministic k-means and return:
        - labels: cluster assignment per sample
        - centroids
        - inertia (sum of squared distances)
        """
        n = x.shape[0]
        k = min(self.k, n)
        rng = np.random.default_rng(self.seed)
        centroids = self._kmeans_plus_plus_init(x, k, rng)

        labels = np.zeros(n, dtype=int)
        for _ in range(self.max_iter):
            d2 = np.stack([np.sum((x - c) ** 2, axis=1) for c in centroids], axis=1)
            new_labels = np.argmin(d2, axis=1)

            if np.array_equal(new_labels, labels):
                labels = new_labels
                break
            labels = new_labels

            new_centroids = []
            for cluster_id in range(k):
                members = x[labels == cluster_id]
                if len(members) == 0:
                    # Empty-cluster fallback: choose farthest sample from current centroids.
                    all_d2 = np.min(
                        np.stack([np.sum((x - c) ** 2, axis=1) for c in centroids], axis=1),
                        axis=1,
                    )
                    farthest_idx = int(np.argmax(all_d2))
                    new_centroids.append(x[farthest_idx])
                else:
                    new_centroids.append(np.mean(members, axis=0))

            new_centroids = np.array(new_centroids, dtype=float)
            shift = float(np.linalg.norm(new_centroids - centroids))
            centroids = new_centroids
            if shift < 1e-9:
                break

        d2_final = np.stack([np.sum((x - c) ** 2, axis=1) for c in centroids], axis=1)
        min_d2 = np.min(d2_final, axis=1)
        inertia = float(np.sum(min_d2))
        return labels, centroids, inertia

    @staticmethod
    def _project_2d_pca(x: np.ndarray) -> np.ndarray:
        """Project features to 2D via PCA (for visualization payload)."""
        if x.shape[0] == 0:
            return np.zeros((0, 2), dtype=float)
        x0 = x - np.mean(x, axis=0, keepdims=True)
        cov = np.cov(x0, rowvar=False)
        eigvals, eigvecs = np.linalg.eigh(cov)
        order = np.argsort(eigvals)[::-1]
        eigvecs = eigvecs[:, order]
        if eigvecs.shape[1] == 1:
            vec2 = np.zeros_like(eigvecs[:, :1])
            basis = np.concatenate([eigvecs[:, :1], vec2], axis=1)
        else:
            basis = eigvecs[:, :2]
        return np.matmul(x0, basis)

    def _cluster_dependencies(self, node_ids: List[int], labels_map: Dict[int, int]) -> Dict[int, set]:
        deps = {cluster_id: set() for cluster_id in sorted(set(labels_map.values()))}
        for node_id in node_ids:
            dst_cluster = labels_map[node_id]
            for sup in self.nodes[node_id]["supporters"]:
                sup_id = sup["id"]
                if sup_id == 0 or sup_id not in labels_map:
                    continue
                src_cluster = labels_map[sup_id]
                if src_cluster != dst_cluster:
                    deps[dst_cluster].add(src_cluster)
        return deps

    def _cluster_priority(self, cluster_id: int, cluster_nodes: Dict[int, List[int]]) -> Tuple[int, int, int]:
        nodes = cluster_nodes.get(cluster_id, [])
        if not nodes:
            return (10**9, 10**9, int(cluster_id))
        min_layer = min(self._safe_layer(node_id) for node_id in nodes)
        min_node = min(nodes)
        return (min_layer, min_node, int(cluster_id))

    def _build_dependency_safe_batches(self, node_ids: List[int], labels_map: Dict[int, int]) -> Tuple[List[List[int]], List[Dict]]:
        """
        Build dependency-safe batches while preserving cluster preference.

        Strategy:
        - always place only "ready" nodes (all supporters already placed)
        - among ready nodes, prefer lower-priority cluster (earlier layer/min id)
        - enforce max batch size

        This guarantees DAG safety at node level and provides stable behavior even when
        cluster-level dependencies are cyclic after assignment.
        """
        placed = set([0])
        pending = set(node_ids)
        batches: List[List[int]] = []
        repair_log: List[Dict] = []

        cluster_nodes: Dict[int, List[int]] = {}
        for node_id in node_ids:
            cluster_nodes.setdefault(labels_map[node_id], []).append(node_id)
        cluster_order = sorted(cluster_nodes.keys(), key=lambda cid: self._cluster_priority(cid, cluster_nodes))

        while pending:
            ready = []
            for node_id in sorted(pending):
                supporters = [sup["id"] for sup in self.nodes[node_id]["supporters"]]
                if all(sup_id in placed for sup_id in supporters):
                    ready.append(node_id)

            if not ready:
                raise ValueError("Graph has cyclic dependencies or unreachable nodes.")

            ready_by_cluster: Dict[int, List[int]] = {}
            for node_id in ready:
                ready_by_cluster.setdefault(labels_map[node_id], []).append(node_id)

            chosen_cluster = None
            for cid in cluster_order:
                if cid in ready_by_cluster and ready_by_cluster[cid]:
                    chosen_cluster = cid
                    break
            if chosen_cluster is None:
                chosen_cluster = labels_map[ready[0]]

            selected = sorted(ready_by_cluster.get(chosen_cluster, ready))[: self.max_batch_size]
            for node_id in selected:
                pending.remove(node_id)
                placed.add(node_id)

            batches.append(selected)

            # Log if we had to bypass an earlier preferred cluster due to dependency lock.
            blocked = [cid for cid in cluster_order if cid not in ready_by_cluster]
            if blocked:
                repair_log.append(
                    {
                        "type": "dependency_gating",
                        "selected_cluster": int(chosen_cluster),
                        "blocked_clusters": [int(cid) for cid in blocked],
                        "batch": selected,
                    }
                )

        return batches, repair_log

    def generate_cluster_report(self) -> Dict:
        """Generate full clustering report for JSON artifact/export and visualization."""
        node_ids, x_raw, feature_names = self._build_feature_matrix()
        x = self._zscore(x_raw)
        labels, centroids, inertia = self._run_kmeans(x)

        labels_map = {node_id: int(labels[idx]) for idx, node_id in enumerate(node_ids)}
        cluster_dependencies = self._cluster_dependencies(node_ids, labels_map)
        batches, repair_log = self._build_dependency_safe_batches(node_ids, labels_map)

        points_2d = self._project_2d_pca(x)

        cluster_to_nodes: Dict[int, List[int]] = {}
        for node_id in node_ids:
            cluster_to_nodes.setdefault(labels_map[node_id], []).append(node_id)

        nodes_payload = []
        for idx, node_id in enumerate(node_ids):
            supporters = [sup["id"] for sup in self.nodes[node_id]["supporters"]]
            nodes_payload.append(
                {
                    "node_id": int(node_id),
                    "object": self.nodes[node_id]["object"],
                    "layer": self._safe_layer(node_id),
                    "supporters": supporters,
                    "feature_vector": [float(v) for v in x_raw[idx].tolist()],
                    "cluster_id": int(labels[idx]),
                    "x_2d": float(points_2d[idx, 0]),
                    "y_2d": float(points_2d[idx, 1]),
                }
            )

        return {
            "meta": {
                "algorithm": "KMeansBranchClustering",
                "k": int(len(cluster_to_nodes)),
                "requested_k": int(self.k),
                "seed": int(self.seed),
                "feature_version": "v1_topology_only",
                "feature_names": feature_names,
                "inertia": float(inertia),
                "max_batch_size": int(self.max_batch_size),
            },
            "clusters": [
                {"cluster_id": int(cluster_id), "nodes": sorted(nodes)}
                for cluster_id, nodes in sorted(cluster_to_nodes.items(), key=lambda kv: kv[0])
            ],
            "cluster_dependencies": {
                str(cluster_id): sorted([int(dep) for dep in deps])
                for cluster_id, deps in sorted(cluster_dependencies.items(), key=lambda kv: kv[0])
            },
            "dependency_repair_log": repair_log,
            "nodes": nodes_payload,
            "global_batches": batches,
            "global_order": [node_id for batch in batches for node_id in batch],
            "centroids": [[float(v) for v in c.tolist()] for c in centroids],
        }

    def generate_optimal_strategy(self):
        """
        Return Prompt1/Prompt2 schema-compatible outputs.
        Downstream Phase2 code can switch to this class without schema changes.
        """
        report = self.generate_cluster_report()

        p1_out = {
            "strategies": [
                {
                    "id": "strategy_1_kmeans_branch",
                    "description": (
                        "Deterministic k-means clustering on target-graph topology "
                        "features with dependency-safe batch reconstruction."
                    ),
                    "order": report["global_order"],
                    "batches": report["global_batches"],
                    "metadata": {
                        "algorithm": "KMeansBranchClustering",
                        "k": report["meta"]["k"],
                        "seed": report["meta"]["seed"],
                        "feature_version": report["meta"]["feature_version"],
                        "cluster_assignment": [
                            {"node_id": item["node_id"], "cluster_id": item["cluster_id"]}
                            for item in report["nodes"]
                        ],
                        "cluster_dependencies": report["cluster_dependencies"],
                        "dependency_repair_log": report["dependency_repair_log"],
                    },
                }
            ]
        }

        p2_out = {
            "selected": "strategy_1_kmeans_branch",
            "reason": (
                "Selected deterministic k-means strategy (target-graph only input) "
                "with DAG-safe batch reconstruction."
            ),
        }

        return p1_out, p2_out
