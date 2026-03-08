# Execution and Automation Protocol (Layer 3)

## 1. Change Proposal Procedure
Any intended codebase modification MUST be prefaced by an RFC or Phase 1 proposal stating:
- Reasoning
- Original Logic
- Expected Result
- First Principles Check (Constraint against existing Architecture).

## 2. Approval Requirement
AI Agents MUST enter a block state awaiting the verbatim string `[APPROVED]` from the human controller before modifying `.cpp`, `.py`, `.fol`, or `.h` files.

## 3. Patch Diff Rule
Any modifications to code must be exact replacements focusing only on the target functions without refactoring out-of-scope behaviors.

## 4. Documentation Update Rule
Upon fixing a bug or adding a feature, the AI MUST review Layer 1 and Layer 2 documents (e.g., `manipTools.md`) to ensure the changes are reflected. If they drift, update the `.md` files immediately.

## 5. Rollback Procedure
All changes should be committed to Git atomically. 
If an AI agent produces a hallucination:
1. `git restore .` (to clear working tree).
2. The current AI session MUST be terminated.
3. A new session must be initiated, which will bootstrap from the uncorrupted Git checkout of the `docs/` hierarchy.

## 6. Consistency Re-Validation Rule
At the start of new sessions, the AI must verify all modules listed in `architecture.md` correspond to existing files in `module_specs/`. Output `CONSISTENCY_ERROR` if mismatched.
