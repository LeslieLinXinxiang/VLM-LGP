# Layer-Based Clustering Minimal Test Report

- Generated at: 2026-04-16 16:53:24
- Input: generated/phase1_target_graph.json
- Output directory: generated/layer_based_policy_run
- Node ID: 301

## 1) Objective

Run a minimal layer-based clustering test with pipeline-compatible IO and generate full executable planning artifacts.

## 2) Algorithm (implemented)

1. Parse support DAG from Phase1 JSON.
2. Compute topological layers.
3. Derive source-provenance sets from table roots (source-priority branching).
4. At each step, select the minimum ready layer as a same-layer execution block.
5. Group same-layer ready nodes by branch key from provenance.
6. Inside each branch, sort nodes left-to-right (edge position first, provenance-root index fallback).
7. Split branch sequence into chunks with max size 2.
8. Emit Prompt1/Prompt2 compatible outputs and generate .fol/.lgp step files.

## 3) Input / Output format contract

### 3.1 Input schema (Phase1)
```json
{
  "objects": [
    {
      "id": "int",
      "object": "str",
      "edges": [
        {
          "supporter": "int",
          "position": "str(optional)"
        }
      ]
    }
  ]
}
```

### 3.2 Output schema (Prompt1)
```json
{
  "strategies": [
    {
      "id": "str",
      "description": "str",
      "order": [
        "int"
      ],
      "batches": [
        [
          "int"
        ]
      ],
      "metadata": "dict"
    }
  ]
}
```

### 3.3 Output schema (Prompt2)
```json
{
  "selected": "str",
  "reason": "str"
}
```

### 3.4 Output schema (Execution Plan)
```json
{
  "algorithm": "str",
  "order": [
    "int"
  ],
  "batches": [
    [
      "int"
    ]
  ],
  "layer_blocks": [
    {
      "layer": "int",
      "same_layer_ready": [
        "int"
      ],
      "branches": [
        {
          "branch_key": "str",
          "ordered_nodes_left_to_right": [
            "int"
          ],
          "chunks": [
            [
              "int"
            ]
          ]
        }
      ]
    }
  ]
}
```

## 4) Run result summary

### 4.1 Selected strategy
```json
{
  "selected": "strategy_1_layer_based",
  "reason": "Deterministic layer-based policy with source-priority semantics."
}
```

### 4.2 Order and batches
```json
{
  "order": [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9
  ],
  "batches": [
    [
      1
    ],
    [
      2
    ],
    [
      3,
      4
    ],
    [
      5,
      6
    ],
    [
      7
    ],
    [
      8
    ],
    [
      9
    ]
  ]
}
```

### 4.3 Layer blocks
```json
[
  {
    "layer": 1,
    "same_layer_ready": [
      1,
      2
    ],
    "branches": [
      {
        "branch_key": "branch:source:1",
        "ordered_nodes_left_to_right": [
          1
        ],
        "chunks": [
          [
            1
          ]
        ]
      },
      {
        "branch_key": "branch:source:2",
        "ordered_nodes_left_to_right": [
          2
        ],
        "chunks": [
          [
            2
          ]
        ]
      }
    ]
  },
  {
    "layer": 2,
    "same_layer_ready": [
      3,
      4,
      5,
      6
    ],
    "branches": [
      {
        "branch_key": "branch:source:1",
        "ordered_nodes_left_to_right": [
          3,
          4
        ],
        "chunks": [
          [
            3,
            4
          ]
        ]
      },
      {
        "branch_key": "branch:source:2",
        "ordered_nodes_left_to_right": [
          5,
          6
        ],
        "chunks": [
          [
            5,
            6
          ]
        ]
      }
    ]
  },
  {
    "layer": 3,
    "same_layer_ready": [
      7
    ],
    "branches": [
      {
        "branch_key": "branch:merge:1,2",
        "ordered_nodes_left_to_right": [
          7
        ],
        "chunks": [
          [
            7
          ]
        ]
      }
    ]
  },
  {
    "layer": 4,
    "same_layer_ready": [
      8
    ],
    "branches": [
      {
        "branch_key": "branch:merge:1,2",
        "ordered_nodes_left_to_right": [
          8
        ],
        "chunks": [
          [
            8
          ]
        ]
      }
    ]
  },
  {
    "layer": 5,
    "same_layer_ready": [
      9
    ],
    "branches": [
      {
        "branch_key": "branch:merge:1,2",
        "ordered_nodes_left_to_right": [
          9
        ],
        "chunks": [
          [
            9
          ]
        ]
      }
    ]
  }
]
```

## 5) Generated artifacts

- execution_plan.json
- policy_trace.json
- phase2_strategy_policy.json
- layer_based_metadata.json
- step_1_batch_1.fol
- step_1_batch_1.lgp
- step_2_batch_1.fol
- step_2_batch_1.lgp
- step_3_batch_1.fol
- step_3_batch_1.lgp
- step_3_batch_2.fol
- step_3_batch_2.lgp
- step_4_batch_1.fol
- step_4_batch_1.lgp
- step_4_batch_2.fol
- step_4_batch_2.lgp
- step_5_batch_1.fol
- step_5_batch_1.lgp
- step_6_batch_1.fol
- step_6_batch_1.lgp
- step_7_batch_1.fol
- step_7_batch_1.lgp

## 6) Notes

- This harness is minimal and deterministic.
- It keeps output schema compatible with current Phase2 codegen consumers.
- It is intended for isolated testing under test/layer_based_clustering.
