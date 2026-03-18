# Test Directory Layout

This folder contains project-owned test assets and scripts.

## Subfolders

- `scenes/`: Canonical and variant `.g` scene files used by tests.
- `integration/`: End-to-end runner scripts (solver + bridge + execution loops).
- `pipeline/`: Phase0/1/2 Python pipeline interface tests.
- `viewers/`: Manual visualization scripts.

## Notes

- Upstream or third-party tests are intentionally not moved here:
  - `rai/test/**`
  - `python_lib/**/tests/**`
- Existing generated outputs under `generated/**` remain untouched.
