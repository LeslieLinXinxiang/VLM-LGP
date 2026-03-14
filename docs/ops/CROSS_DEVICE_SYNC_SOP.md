# Cross-Device Sync SOP (Mac + Linux)

## TL;DR
- You do NOT need to create/upload a new branch every time.
- You should keep working on one shared branch (for example: `docs/add-paper-module`) and push new commits to that same branch.
- Branch is a long-lived lane; commits are the actual updates.

## 1. Do I Need to "Upload Branch" Every Time?
No.

What you need every time is:
1. `git pull` before starting work.
2. `git add/commit/push` after finishing work.

You only create a new branch when:
- You start a new independent feature/topic.
- You need isolation for risky experiments.
- You want a clean PR scope.

## 2. Standard Daily Flow (Two Computers)
Use the same branch on both machines.

### 2.1 Start Work (on current machine)
```bash
cd ~/Projects/VLM-LGP
git checkout docs/add-paper-module
git pull origin docs/add-paper-module
```

### 2.2 Finish Work (push updates)
```bash
cd ~/Projects/VLM-LGP
git add -A
git commit -m "update code/paper"
git push origin docs/add-paper-module
```

### 2.3 Continue on the Other Machine
```bash
cd ~/Projects/VLM-LGP
git checkout docs/add-paper-module
git pull origin docs/add-paper-module
```

## 3. Fast Status Check
Before switching machines, run:
```bash
git fetch origin && git status -sb
```

Interpretation:
- `ahead` -> you have local commits not pushed yet.
- `behind` -> remote has updates; run `git pull`.
- clean and no ahead/behind -> already synced.

## 4. Conflict Handling (Minimal)
If pull reports conflict:
1. Resolve conflict files.
2. Stage them.
3. Commit and push.

```bash
git status
# resolve files manually
git add <resolved_files>
git commit -m "resolve merge conflict"
git push origin docs/add-paper-module
```

## 5. Recommended Branch Strategy for This Project
- Keep one active collaboration branch for code+paper sync (current: `docs/add-paper-module`).
- Use topic branches only when needed.
- Merge back after review.

## 6. Optional: Quick Pull Script
```bash
#!/usr/bin/env bash
set -e
cd ~/Projects/VLM-LGP
git checkout docs/add-paper-module
git pull origin docs/add-paper-module
git status -sb
```
