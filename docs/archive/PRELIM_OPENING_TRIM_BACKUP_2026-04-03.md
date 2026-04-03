# Preliminaries Opening Trim Backup (2026-04-03)

## 1. Purpose

This note stores content trimmed from the opening of `paper/VLM-LGP-Assembly/bare_jrnl.tex` when the `Preliminaries and Problem Statement` section was tightened to serve as a landscape-level problem setup.

The goal is not to discard these details permanently, but to preserve them for later reuse in more appropriate locations.

## 2. Why the Trim Was Needed

The opening of `Preliminaries and Problem Statement` should primarily do three things:

1. establish the native-LGP background and long-horizon bottleneck,
2. introduce the structural formulation at a high level,
3. define the planning objective without turning the section opening into a method-style walkthrough.

The previous version contained correct content, but some graph-level details were too dense for the early landscape function of this section.

## 3. Trimmed Content and Recommended Reuse

### Item A: Support-precedence asymmetry sentence

Trimmed content:

> The graph is directed because support precedence is asymmetric: if $(u,v)\in\mathcal{E}$, then object $u$ must be realized before object $v$ can be stably placed.

Reason for trimming:

- Correct but too explanatory for the current paragraph density.
- Better used when the paper explicitly discusses graph semantics instead of opening-level framing.

Recommended later location:

- `Preliminaries and Problem Statement`, if a later paragraph is added specifically for graph semantics.
- Or `VLM-Based Support Graph Generation`, when explaining how edges are interpreted by downstream decomposition.

### Item B: Optional edge-attribute sentence

Trimmed content:

> Optional edge attributes, such as left/right placement labels at the support interface, are kept as local geometric hints but do not by themselves define the execution order.

Reason for trimming:

- This is an implementation-facing nuance, not part of the minimum problem statement.
- It increases local density before the reader has fully internalized the main graph abstraction.

Recommended later location:

- `VLM-Based Support Graph Generation`
- Figure caption or accompanying text for graph examples

### Item C: Full batch-validity constraint sentence

Trimmed content:

> ... such that every object appears exactly once, every batch remains within the current solver scale, and every support predecessor of a node in $B_t$ has already appeared in an earlier batch.

Reason for trimming:

- The full constraint list is useful, but it is heavy for the compressed opening.
- The reduced current version keeps the planning objective while avoiding a long multi-clause sentence.

Recommended later location:

- a dedicated formal problem statement paragraph,
- or a compact numbered constraint formulation if the section later needs stronger mathematical explicitness.

### Item D: Explicit restatement sentence

Trimmed content:

> In other words, the system must produce a decomposition that is both structurally valid and suitable for downstream geometric solving.

Reason for trimming:

- The sentence is good rhetorically, but it became redundant after the planning-goal sentence was shortened.

Recommended later location:

- end of a formal problem-definition paragraph,
- or Method overview as a transition from representation to solving.

## 4. Current Writing Decision

After trimming, the opening of `Preliminaries and Problem Statement` should keep only:

1. native LGP advantage,
2. long-horizon branching bottleneck,
3. high-level object-support graph formulation,
4. compact planning objective,
5. decomposition motivation.

This keeps the section aligned with a RA-L-style problem framing rather than a premature method walkthrough.

## 5. Reuse Rule

If later revisions make the problem statement feel too thin, reintroduce trimmed content in this order:

1. Item C
2. Item A
3. Item D
4. Item B

This order prioritizes formal clarity before implementation nuance.

## 6. Additional Trim for Landscape-Only Opening

During the later refinement pass on 2026-04-03, the opening paragraph of `Preliminaries and Problem Statement` was further reduced so that it performs only:

1. prior-method limitation framing,
2. long-horizon native-LGP bottleneck,
3. introduction of VLM-LGP as the response.

The following content was intentionally removed from the first paragraph and either kept in later paragraphs or moved to the Method overview:

- explicit mention of the object-support graph as the immediate first-paragraph solution object,
- system-level module split (`Scene Initialization` and `Task Decomposition`),
- pipeline-level phrases such as graph generation, graph decomposition, and execution sequencing,
- module-specific details such as reachability screening and manipulability prioritization.

Reason for this later trim:

- The first paragraph should act as landscape and motivation only.
- Framework overview belongs to the opening of `Method`.
- Module internals belong to the corresponding subsections, not to the overview paragraph.

## 7. Graph Formalization Relocation

In a later refinement pass, the symbolic graph notation was further reduced in
`Preliminaries and Problem Statement` and relocated into the subsection
`VLM-Based Support Graph Generation`.

Reason:

- `Preliminaries` should only state the problem formulation at a high level.
- The explicit graph definition is more useful when attached to the VLM-stage rationale
  that explains why graph output is the right abstraction.
- This relocation keeps notation close to the module that actually produces the graph.
