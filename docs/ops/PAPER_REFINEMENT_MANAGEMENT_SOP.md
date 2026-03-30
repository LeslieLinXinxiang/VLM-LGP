# Paper Refinement Management SOP (RA-L Draft)

## 1) Purpose

This SOP governs paragraph-by-paragraph refinement for the paper draft, with emphasis on:

- style consistency across sessions/agents,
- strict logic consistency with the implemented VLM-LGP pipeline,
- terminology consistency between method text and flowchart labels,
- bilingual CN/EN output for each refined paragraph.

Scope (current cycle): `paper/VLM-LGP-Assembly/bare_jrnl.tex` Method section.

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

4. **Bilingual delivery rule**
   - Every paragraph refinement round outputs:
     - CN literal understanding (or direct translation),
     - EN candidate text for manuscript insertion,
     - short rationale and risk notes.

---

## 3) Method Naming Alignment (Flowchart <-> Manuscript)

Use the following canonical mapping for editing and review tracking.

- Phase 0: **Scene Grounding and Feasibility Screening**
- Phase 1: **Support Graph Construction**
- Phase 2a: **Branch-Based Cutting**
- Phase 2b: **Layer-Based Cutting**
- Phase 3: **Selective Native LGP Instantiation and Solving**
- Phase 4: **Robot Execution**

Notes:

- Internal module binding (for agent navigation, not mandatory manuscript wording):
  - Phase 0 -> `pipeline/run_phase0.py`
  - Phase 1 -> `pipeline/run_phase1.py`
  - Phase 2a/2b + codegen/solve orchestration -> `pipeline/run_phase2.py`
  - Driver loop -> `driver.py`

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

For each paragraph in Method:

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

- [ ] Refine Method opening paragraph with bilingual A/B/C versions.
- [ ] Freeze a preferred style template from selected version.
- [ ] Apply same template to next Method subsection opening paragraphs.
- [ ] Run a terminology sweep against phase headers and flowchart labels.
- [ ] Record decisions in `docs/roadmap.md` task timeline.
