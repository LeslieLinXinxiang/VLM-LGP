# Stage 1 timing: the paper's geometric accessibility score

`rho = rho_spa + alpha * rho_clear`, with `rho_spa` and `rho_clear` exactly as
written in the paper. The score the pipeline currently computes is a different
formula (no leading `1 -`, self-kernel included, and a second term measuring
distance to obstacle frames rather than to the nearest object), so its cost is
not what this stage would cost as published; hence this separate measurement.

Each scene timed over 200 repetitions; the value is the per-call mean.
Scene parsing and layout construction are excluded -- they are shared with the
rest of phase 0 and are not part of the score itself.

| Benchmark | Magnitude | Cond | Objects | Paper score (ms) |
|---|---|---|---|---|
| Cube Stacking | 4cubes | NR | 4 | 0.1326 ± 0.0142 |
| Cube Stacking | 4cubes | R | 8 | 0.1652 ± 0.0164 |
| Cube Stacking | 5cubes | NR | 5 | 0.1314 ± 0.0086 |
| Cube Stacking | 5cubes | R | 10 | 0.1813 ± 0.0180 |
| Cube Stacking | 6cubes | NR | 6 | 0.1576 ± 0.0131 |
| Cube Stacking | 6cubes | R | 12 | 0.2318 ± 0.0255 |
| Cube Stacking | 7cubes | NR | 7 | 0.1621 ± 0.0145 |
| Cube Stacking | 7cubes | R | 14 | 0.2421 ± 0.0285 |
| Cube Stacking | 8cubes | NR | 8 | 0.1843 ± 0.0135 |
| Cube Stacking | 8cubes | R | 16 | 0.2876 ± 0.0283 |
| FMB | 3objs | NR | 3 | 0.1335 ± 0.0086 |
| FMB | 3objs | R | 6 | 0.1728 ± 0.0174 |
| FMB | 4objs | NR | 4 | 0.1471 ± 0.0062 |
| FMB | 4objs | R | 8 | 0.1996 ± 0.0121 |
| FMB | 5objs | NR | 5 | 0.1599 ± 0.0041 |
| FMB | 5objs | R | 10 | 0.2278 ± 0.0093 |
