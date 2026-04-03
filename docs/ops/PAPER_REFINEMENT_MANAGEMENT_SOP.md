# Paper Refinement Management SOP (RA-L Draft)

## 1) Purpose

This SOP governs paragraph-by-paragraph refinement for the paper draft, with emphasis on:

- style consistency across sessions/agents,
- strict logic consistency with the implemented VLM-LGP pipeline,
- terminology consistency between method text and flowchart labels,
- bilingual CN/EN output for each refined paragraph.

Scope (current cycle): `paper/VLM-LGP-Assembly/bare_jrnl.tex`, with current emphasis on `Preliminaries and Problem Statement` and `Method`.

Authority note:

- `docs/governance/PAPER_REFINEMENT_CONTENT_LOCK.md` locks the paper-level story backbone and canonical terminology.
- This SOP governs the execution workflow after that content lock has been loaded.

---

## 2) Non-Negotiable Constraints

1. **Conservative claim style (RA-L)**
   - Prefer: “we formulate”, “we introduce”, “we instantiate selectively”, “this improves efficiency in our setting”.
   - Avoid unsupported strong claims: “state-of-the-art”, “solves generally”, “guarantees global optimality”.

2. **Pipeline truth source**
   - Must align with current implementation contracts in:
     - `docs/architecture.md`
     - `docs/dataflow.md`
     - `docs/execution_protocol.md`
   - If text conflicts with implementation, mark as **Logic Divergence** and escalate before merging wording.

3. **Terminology lock**
   - Keep core terms stable unless explicit approval is given.
   - Do not introduce new algorithm names that are not implemented or already accepted.
   - Use the canonical stage labels from `docs/governance/PAPER_REFINEMENT_CONTENT_LOCK.md`.

4. **Bilingual delivery rule**
   - Every paragraph refinement round outputs:
     - CN literal understanding (or direct translation),
     - EN candidate text for manuscript insertion,
     - short rationale and risk notes.

---

## 3) Method Naming Alignment (Flowchart <-> Manuscript)

Use the following canonical mapping for editing and review tracking.

- Phase 0: **Scene Grounding and Feasibility Screening**
- Phase 1: **VLM-Based Support Graph Generation**
- Phase 2: **Two-Level Graph Decomposition**
- Phase 2a: **Branch Clustering**
- Phase 2b: **Layer-Based Cutting**
- Phase 3: **Selective Native LGP Instantiation and Solving**
- Phase 4: **Robot Execution**

Notes:

- Internal module binding (for agent navigation, not mandatory manuscript wording):
  - Phase 0 -> `pipeline/run_phase0.py`
  - Phase 1 -> `pipeline/run_phase1.py`
  - Phase 2a/2b + codegen/solve orchestration -> `pipeline/run_phase2.py`
  - Driver loop -> `driver.py`

Additional paper-level module view:

- `Scene Initialization`
- `Task Decomposition`

These two directions merge at Phase 3.

---

## 4) Style Profile (Anchored to Accepted References)

Reference tone anchors:

- Yu et al. (2026), skill-graph framing style: explicit representation -> staged transformation -> execution interface.
- Tian et al. (2025) Fabrica: systems narrative with clear module boundaries and conservative empirical phrasing.

Target writing profile:

- sentence-level clarity over rhetorical flourish,
- “problem first -> key idea -> staged procedure” paragraph skeleton,
- explicit interface language (upstream/downstream, representation/instantiation),
- stable vocabulary across sections.

---

## 5) Paragraph Refinement Workflow (Required)

For each target paragraph in the current draft:

1. **Literal pass**: produce CN literal translation/understanding.
2. **Issue pass**: identify structure, tone, redundancy, and logic risks.
3. **Three-scheme rewrite**:
   - Scheme A: compact and neutral (for tight page budget),
   - Scheme B: balanced narrative (default),
   - Scheme C: explicit interface emphasis (for reviewer clarity).
4. **Consistency check**:
   - terms vs section headers and flowchart labels,
   - claims vs implementation truth,
   - consistency with preceding/following paragraph.
5. **Selection and lock**:
   - user picks one scheme (or mixed edit),
   - chosen scheme becomes local style anchor for subsequent paragraphs.

Before this workflow begins for a new session:

1. reload `docs/governance/PAPER_REFINEMENT_CONTENT_LOCK.md`,
2. verify the current target paragraph still matches the locked story backbone,
3. only then enter the literal/issue/rewrite passes.

## 5.1) First-Paragraph Global-Awareness Rule

For the opening paragraph in `Preliminaries and Problem Statement`, the paragraph should not jump directly into graph formalization.

The default rhetorical order is:

1. native LGP advantage,
2. long-horizon assembly bottleneck,
3. VLM-LGP core idea,
4. high-level system decomposition.

---

## 6) Logic Divergence Escalation Rule

Flag and escalate to user if any of the following appears:

- wording implies VLM decides final execution sequence directly,
- wording bypasses Phase1-ID -> scene binding contract,
- wording collapses branch-based and layer-based steps into one opaque process,
- wording suggests full-horizon monolithic LGP execution as default.

Escalation template:

- Divergence type:
- Current text fragment:
- Conflict source (file/section):
- Recommended fix options (A/B):

---

## 7) Change Log Template (for each paragraph round)

- Date/time:
- Paragraph location:
- Selected scheme:
- Main edits:
- Terms touched:
- Logic divergence found? (Y/N)
- Follow-up dependency:

---

## 8) Immediate Task Checklist (Current Sprint)

- [ ] Lock the global story backbone for `Preliminaries and Problem Statement`.
- [ ] Freeze canonical stage names and high-level module names.
- [ ] Synchronize flowchart labels and manuscript terminology.
- [ ] Refine the first paragraph under the global-awareness rule.
- [ ] Record decisions in `docs/roadmap.md` task timeline.
