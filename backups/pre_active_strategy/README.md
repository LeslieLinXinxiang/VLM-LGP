# Pre-Active Strategy Backup

- Source commit: `503cdba` (`backup: local state before merge with remote main (2026-03-08)`)
- Purpose: Baseline without active collision runtime injection for A/B solve-time comparison.
- Primary file: `main.cpp.pre_active_503cdba.cpp`

## Note on commit scope
Active strategy introduction commits changed more than `bin/main.cpp`:
- `ff7730d` (V1): touched docs, LGP default config path, integration test artifacts, and `bin/main.cpp`.
- `5ab5539` (V2): touched `bin/main.cpp` and generated scene files.

For runtime A/B, this backup pins the executable-side baseline entrypoint only.
