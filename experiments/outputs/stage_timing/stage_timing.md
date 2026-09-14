# Per-stage timing: reachability filtering and manipulability ordering

Measured inside `execute_phase0` on the real pipeline path. Both stages are
per-object and the redundancy condition doubles the object count, so NR and R are
reported separately — the pair is what shows the scaling. VLM graph generation is
excluded by agreement (network-bound).

Runs per cell: 10. Times are mean ± population SD.

| Benchmark | Magnitude | Cond | Objects | Stage 1 score (ms) | Stage 2 KOMO (ms) | Reachability total (ms) | Manipulability (ms) | Obj scored |
|---|---|---|---|---|---|---|---|---|
| Cube Stacking | 4cubes | NR | 4 | 0.289 ± 0.030 | 963.5 ± 16.1 | 964.1 ± 16.1 | 10.90 ± 0.71 | 4 |
| Cube Stacking | 4cubes | R | 8 | 0.328 ± 0.025 | 2042.4 ± 19.4 | 2043.1 ± 19.4 | 20.67 ± 0.41 | 8 |
| Cube Stacking | 5cubes | NR | 5 | 0.306 ± 0.039 | 1232.2 ± 14.9 | 1232.9 ± 14.9 | 13.26 ± 0.37 | 5 |
| Cube Stacking | 5cubes | R | 10 | 0.370 ± 0.032 | 2649.2 ± 83.2 | 2650.0 ± 83.2 | 25.54 ± 0.54 | 10 |
| Cube Stacking | 6cubes | NR | 6 | 0.340 ± 0.043 | 1499.0 ± 25.5 | 1499.7 ± 25.5 | 15.79 ± 0.53 | 6 |
| Cube Stacking | 6cubes | R | 12 | 0.445 ± 0.037 | 3246.1 ± 51.2 | 3247.0 ± 51.2 | 31.29 ± 0.90 | 12 |
| Cube Stacking | 7cubes | NR | 7 | 0.349 ± 0.028 | 1802.4 ± 47.2 | 1803.2 ± 47.2 | 18.70 ± 0.69 | 7 |
| Cube Stacking | 7cubes | R | 14 | 0.449 ± 0.038 | 3883.1 ± 83.5 | 3884.1 ± 83.5 | 35.09 ± 1.24 | 14 |
| Cube Stacking | 8cubes | NR | 8 | 0.381 ± 0.043 | 2076.1 ± 34.3 | 2076.9 ± 34.3 | 21.38 ± 0.35 | 8 |
| Cube Stacking | 8cubes | R | 16 | 0.491 ± 0.038 | 4439.9 ± 202.2 | 4441.0 ± 202.2 | 39.03 ± 1.64 | 15 |
| FMB | 3objs | NR | 3 | 0.297 ± 0.024 | 785.1 ± 29.9 | 785.7 ± 29.9 | 8.67 ± 1.05 | 2 |
| FMB | 3objs | R | 6 | 0.355 ± 0.037 | 1613.1 ± 36.8 | 1613.9 ± 36.8 | 18.16 ± 1.11 | 6 |
| FMB | 4objs | NR | 4 | 0.322 ± 0.019 | 1042.0 ± 32.8 | 1042.6 ± 32.8 | 11.49 ± 1.21 | 3 |
| FMB | 4objs | R | 8 | 0.388 ± 0.020 | 2203.4 ± 75.0 | 2204.2 ± 75.0 | 23.69 ± 1.65 | 7 |
| FMB | 5objs | NR | 5 | 0.351 ± 0.026 | 1336.5 ± 39.3 | 1337.3 ± 39.4 | 14.89 ± 1.13 | 5 |
| FMB | 5objs | R | 10 | 0.424 ± 0.032 | 2748.7 ± 33.3 | 2749.7 ± 33.3 | 28.32 ± 1.43 | 10 |

Within reachability the KOMO gate costs about **5447x** the geometric
score: the score is closed-form over object positions, the gate runs one KOMO
solve per object. The gate is currently run over every object rather than over
the score's survivors, so the pre-filter does not yet reduce KOMO solves.

Reachability costs roughly **97x** what manipulability ordering costs:
the manipulability score is a Jacobian determinant at an IK solution, whereas
reachability runs a KOMO solve per object.
