# Paper Refinement Content Lock (RA-L Draft)

## 1. Purpose

This document locks the global story backbone, canonical terminology, and figure-to-text alignment for the current paper refinement cycle.

It complements, but does not replace, the execution workflow in `docs/ops/PAPER_REFINEMENT_MANAGEMENT_SOP.md`.

## 2. Authority and Read Order

Use this document first when refining the manuscript.

Recommended startup order for each new paper-writing session:

1. Read this file to recover the current story backbone and terminology lock.
2. Read `docs/ops/PAPER_REFINEMENT_MANAGEMENT_SOP.md` for the paragraph-by-paragraph execution workflow.
3. Then edit `paper/VLM-LGP-Assembly/bare_jrnl.tex`.

## 3. Locked Story Backbone

The paper should follow the backbone below unless explicitly revised and re-locked.

1. **Native LGP advantage**:
   Native LGP is valuable because it couples task structure and motion reasoning in one framework, making manipulation task specification more direct than purely symbolic PDDL-style formulations.
2. **Native LGP bottleneck**:
   Long-horizon assembly still causes excessive symbolic branching before geometric infeasibility can prune the search, which makes complex stacked assemblies expensive and hardware-demanding.
3. **Core VLM-LGP insight**:
   The task logic of LGP is close to natural-language relational structure, while long-horizon assemblies are naturally represented as object-support graphs. This makes VLMs suitable as a front-end structure parser rather than a direct motion or code generator.
4. **System-level solution**:
   VLM-LGP first converts the target assembly image into an object-support graph, then decomposes the graph into solver-facing subproblems, and finally instantiates native LGP selectively for execution.
5. **Two-module system view**:
   The full pipeline should be explained through two coordinated directions:
   - `Scene Grounding`
   - `Task Decomposition`
6. **Merge point**:
   These two directions merge at `Execution-Order Embedding` and are then passed to selective LGP solving, followed by real robot execution.

## 4. First-Paragraph Role Lock

For `Section I. Preliminaries and Problem Statement`, the opening paragraph must establish global awareness for the full paper.

The preferred message order is:

1. state why native LGP is attractive,
2. state why long-horizon assembly stresses native LGP,
3. introduce VLM-LGP as the structural interface solution,
4. preview the two major system directions and the decomposition chain.

Do not open this section by immediately defining the support graph without first stating the problem context.

## 5. Canonical Terminology Lock

Use the following terms consistently across the paper.

### 5.1 Inputs and Core Representations

- **Target assembly image**: the visual task specification provided to the VLM.
- **Object-support graph**: the structural representation of the desired final assembly.
- **Solver-facing subproblem / solver-facing batch**: a decomposed unit passed to native LGP.

### 5.2 High-Level Modules

- **Scene Grounding**
- **Task Decomposition**
- **Execution-Order Embedding**
- **Selective LGP Solving with Active Constraints**
- **Real Robot Execution**

### 5.3 Scene Grounding Sub-terms

- **Reachability screening**
- **Unreachable object pruning**
- **Manipulability-aware ordering**
- **Grounded object inventory** (keep only if the paragraph explicitly needs the inventory concept)

### 5.4 Task Decomposition Chain

Use this exact high-level chain when describing the planning-side pipeline:

1. **VLM Graph Generation**
2. **Two-Level Clustering**
3. **Branch Clustering**
4. **Layer-Based Cutting**
5. **Global Execution Sequence**

### 5.5 Naming Rule for `generation` vs `construction`

Lock the stage name as **VLM Graph Generation**.

Rationale:

- The stage input is a `target assembly image`.
- The stage output is a graph produced by the VLM front-end.
- `generation` better matches the input-output semantics and the current planning figure.

Allowed usage:

- `construct` or `constructs` may still be used as a verb in prose when describing what the system does.
- `construction` should not replace `generation` as the formal stage title.

## 6. Figure-to-Text Alignment Lock

The planning-side figure and manuscript text should stay aligned to the same three-part logic:

1. **VLM Graph Generation**
2. **Two-Level Clustering**
   - **Branch Clustering**
   - **Layer-Based Cutting**
3. **Global Execution Sequence**

At the system level, the manuscript should also preserve the broader two-direction view:

- `Scene Grounding`
- `Task Decomposition`

These two directions then merge into `Execution-Order Embedding`, followed by `Selective LGP Solving with Active Constraints` and `Real Robot Execution`.

## 7. Claim-Style Lock

Use conservative RA-L phrasing.

Prefer:

- `we introduce`
- `we formulate`
- `we decompose`
- `we instantiate selectively`
- `this reduces search complexity in our setting`
- `this improves usability and scalability in our setting`

Avoid:

- `solves generally`
- `guarantees`
- `state-of-the-art`
- `dramatically`
- `fully eliminates`

## 8. Writing Granularity Lock

When refining paragraphs, keep each paragraph centered on one message only.

For the current draft:

- the first paragraph in `Preliminaries and Problem Statement` should carry the global problem framing,
- later paragraphs in that section can formalize representations and constraints,
- the `Method` overview should reuse the same locked terms instead of rebranding the modules.

## 9. Session Checklist

Before accepting a revised paragraph, verify:

1. Does it match the locked story backbone?
2. Does it use the canonical stage names exactly?
3. Does it distinguish `Scene Grounding` from `Task Decomposition`?
4. Does it distinguish graph representation, graph decomposition, and final execution order?
5. Are the claims conservative enough for current evidence?
