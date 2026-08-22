# MISSION: VLM-MSGRAPH BASELINE — MODULE A SEMANTIC TRIPLE SEQUENCING (SINGLE-CALL, 5-ROLE CHAIN)

You are reproducing **Module A** of the VLM-MSGraph method (Li et al., *Robotics and
Computer-Integrated Manufacturing* 94 (2025) 102978, §3.1): a high-level semantic
sequencing stage that turns one image of a target assembly into an **ordered list of
`<subject, predicate, object>` triples**.

You do **not** compute or output any numeric coordinate, pose, or motion at this stage.
Everything you produce is symbolic: object names, relations, and an assembly order.
Low-level execution (grounding, pose, grasp, motion) is a separate module and is not
your concern.

You will act as **five roles across three stages**, in order, inside a single response.
Each role's output becomes the input to the next. Do not skip a role or merge two roles'
work into one step — the staged structure is the method being tested.

---

## 1. INPUT CONTRACT

You are given:

1. **One image** of the fully assembled target structure. This is the only visual input —
   there is no separate top-down/isometric panel and no coordinate overlay.
2. **A part list**, appended below this prompt as plain text, in the form:

   ```
   PART_LIST:
   - <object_name>: <quantity>
   - <object_name>: <quantity>
   ...
   ```

   This lists object **names and quantities only** — no positions, no coordinates, no
   dimensions. Use these names exactly as given; do not rename, merge, or invent objects.
   If the image appears to show a different count than the part list states, trust the
   part list for identity/quantity and use the image only for relations and geometry-free
   spatial layout.

   **Multiple instances of the same name**: when a part-list entry has quantity > 1
   (e.g. `Cube: 4`), every triple must refer to a *specific* instance, never the bare
   type name. Append a 1-based index to the exact part-list name, in a fixed scan order
   (left-to-right, then bottom-to-top): `Cube_1`, `Cube_2`, `Cube_3`, `Cube_4`. Assign
   each physical instance exactly one index the first time it is mentioned (by whichever
   role mentions it first), and every later role must reuse that same index for that same
   physical instance — never reassign an index or introduce a second index for one object.
   A quantity-1 entry is referred to by its bare part-list name (no index).

You never receive a `SCENE` block, object coordinates, or any numeric pose. This matches
the input contract of our own high-level planner — both methods start from the same
information.

---

## 2. PREDICATE VOCABULARY

Use only these predicates. Do not invent new ones.

**Spatial relations** (used by Relation Narrator / Image Narrator, stage 1):
- `above`, `below`, `left`, `right`, `front`, `back`, `on`, `adjacent_to`

`front`/`back` describe the axis running toward/away from the viewer (or, for a
composite image with a labeled Top-Down View panel, toward/away from that panel's near
edge) — this is a *different* axis from `left`/`right`. Objects can be laid out along
either axis, or both (rare, see Section 3).

**Assembly-action verbs** (used by Action Narrator, stage 2, and in the final output):
- `attach_to`, `screw`, `insert`, `wrap`, `go_through`

A triple's `predicate` must be exactly one of the above strings. Spatial predicates
describe what you observe in the image; action predicates describe what must physically
happen to reach that configuration, chosen by matching the observed geometric relation
to the most specific applicable action verb (e.g. a peg visually `inside` a hole →
`insert`; a part visually `on` a threaded post → `screw`; a flexible part looped around
another → `wrap`; one part passing fully through another → `go_through`; anything else
that is simple contact/mounting → `attach_to`).

**Position values** (used only in the `"position"` field described in Section 3 — never
as a triple's `predicate` itself, and only ever as a *value*, never a key):
`left`, `right`, `front`, `back`, plus **`center`**. Note this list is **not** the same
as the spatial-predicate list above: `above`, `below`, `on`, and `adjacent_to` are never
valid `"position"` values — being above/below/touching is already implied by the
`attach_to` edge itself and disambiguates nothing among siblings on the same edge.

`center` exists only as a position value, not a triple predicate: use it for an object
that sits *between* two siblings on one axis rather than to one side of all of them —
the tell is that stage 1 recorded that object in **two spatial triples, on the *same*
axis, with opposite sides, against two different siblings** (e.g. `[X, right, A]` and
`[X, left, B]` — X is right of A *and* left of B, which only happens if X is between
them on the left/right axis; the equivalent applies to `front`/`back`). Do not assign
the same one-sided value (e.g. `left`) to two different siblings on the same edge, and
do not pick one of an object's two opposite-side relations arbitrarily when `center` is
the relation that is actually true — position values among siblings on one shared edge
must all be distinct.

---

## 3. THE FIVE ROLES (WORKFLOW, MANDATORY ORDER)

Write each role's output as its own labeled block inside `REASONING_DRAFT`. Each role may
only use information produced by itself or by an earlier role.

### Stage 1 — Parallel triple extraction

**Role: Relation Narrator**
- Scan the image and the part list.
- For every pair of objects that are in direct visual/physical relation, emit one triple
  using a **spatial** predicate.
- Do not infer relations between objects that do not visually touch or align.

**Role: Image Narrator**
- Independently re-scan the image, focused on relations Relation Narrator may have
  missed (occluded contact, small/thin parts, relations implied by shape fit e.g. a hole
  aligned with a peg).
- Emit additional triples, spatial or — if the physical fit is unambiguous from shape
  alone (peg/hole, thread/post, loop/spool) — action predicates.
- Do not repeat a triple Relation Narrator already emitted.

### Stage 2 — Anchor selection and reordering

**Role: Base Searcher**
- From the combined triple set of stage 1, identify the single **anchor object**: the
  object that is never the `object` of an action-type relation (nothing attaches to it
  from below/before it exists) and that the largest number of other objects ultimately
  depend on. For Cube Stacking this is normally `table`; for FMB this is normally the
  base/vendor plate if present in the part list, otherwise the largest/most-connected part.
- State the anchor object and a one-line justification.

**Role: Action Narrator**
- First, for every object other than the anchor, identify its **one true supporting
  relation**: the single spatial triple from stage 1 that describes what it physically
  rests on / is joined to (an `on` relation, or whichever relation the object's stability
  actually depends on — e.g. a peg's `inside` a hole). An object normally has exactly one
  supporting relation; a bridging object resting on several supporters at once may have
  more than one.
- **`left`, `right`, `above`(when not also the supporting relation), and `adjacent_to`
  triples between two objects that each independently rest on their own supporter are
  positional/identification information only — they never generate their own action
  step.** Do not emit `[A, attach_to, B]` just because stage 1 recorded `[A, left, B]` or
  `[A, adjacent_to, B]`; that only means A and B sit next to each other on whatever they
  are each actually supported by, not that A attaches to B. Concretely: if raw_triples
  has both `[A, on, table]` and `[A, left, B]`, the *only* action step for A is
  `[A, attach_to, table]` — never also `[A, attach_to, B]`.
- Starting from the anchor object, walk the *supporting relations only* outward (anchor's
  direct neighbors first, then their neighbors, etc.) and reorder them into an
  **assembly sequence**: the order in which parts would physically need to be added to
  reach the final image, anchor first. Each object appears as `subject` exactly once,
  using its true supporting relation(s) from the step above.
- Convert each supporting relation to use an **assembly-action** predicate (not a
  spatial one) — this is the step where spatial observations become actions. A relation
  with an unavoidably ambiguous action (plain contact, no thread/hole/wrap cue) stays
  `attach_to`.
- **One placement action = one `ordered_triples` row, always** — this is a hard
  structural rule, not a style preference. If an object rests on a single supporter,
  `"object"` is that supporter's name (a string). If it is a bridging object resting on
  several supporters at once, `"object"` is the **array** of every one of those
  supporters' names (e.g. `["RectPrism_4", "RectPrism_5"]`) — never split a bridging
  object's supporters across multiple rows, and never invent multiple `step` numbers for
  one object. This matches how it will actually be executed: one grasp, one placement,
  registered against however many contact points that one placement creates. `step`
  values are always unique, sequential integers, one per row, with no gaps or repeats.
- **Positional disambiguation is not optional information — without it, the sequence
  cannot be executed. But it is needed far less often than it looks, so check carefully
  before adding it.** The question is never "does this object share *a* supporter with
  someone" — a bridging object almost always shares at least one individual supporter
  with something. The question is **does this object's *complete* supporter set (as an
  unordered set — `{"RectPrism_4","RectPrism_5"}` is one set) exactly match another
  row's complete supporter set?** If every row's supporter set is unique across the
  whole `ordered_triples` list, **no row needs `"position"` at all** — the named
  supporter(s) alone already pin down where each object goes, uniquely, with nothing
  left to disambiguate. Two different partial overlaps (e.g. `{P,Q}` vs `{Q,R}`) are
  *not* the same set and do *not* need `"position"` just because they share `Q` — `Q`
  being common tells you nothing extra once the two sets are already distinguishable by
  their other member.
  - Only when 2+ rows have the *exact same* supporter set, assign `"position"`: collect
    *all* of stage 1's spatial triples between those objects directly (not just the
    first one found), then assign the value:
    - Exactly one one-sided relation between them on one axis (e.g. only ever `left` of
      the others, never `right`; the same logic applies to `front`/`back`) → use that
      word.
    - Opposite-sided relations against two *different* others in the tied group, on the
      *same* axis (e.g. `right` of one and `left` of another) → this object is between
      them on that axis → use `center` (see Section 2).
    - Never reuse a position value already assigned to another row in the same tied
      group — if that would happen, you mis-assigned one of them; recheck which one is
      actually `center`.
  - **Worked example — two bridging objects with different (non-tied) supporter sets:**
    B rests on {P, Q}, C rests on {Q, R}. `{P,Q} != {Q,R}`, so neither row needs
    `"position"` — write `{"subject":"B","predicate":"attach_to","object":["P","Q"]}`
    and `{"subject":"C","predicate":"attach_to","object":["Q","R"]}` with no
    `"position"` key on either, even though both touch Q.
  - **Worked example — a genuine tie needing `"position"`:** three single-supporter
    siblings D, E, F all have `"object": "table"` — same set (a singleton `{"table"}`)
    repeated three times — so all three need `"position"` (`left`/`center`/`right` per
    the rule above). This is the ordinary sibling-row case from before.

### Stage 3 — Self-review

**Role: Triple Extractor**
- Re-check the ordered sequence from stage 2 against the image and part list:
  - Every object in the part list appears at least once (except the anchor, which never
    needs to be attached to anything).
  - No object is used as `subject` before all objects it structurally depends on have
    already appeared as `subject` earlier in the sequence.
  - No duplicate triples, no contradictory relations (e.g. both `A above B` and `B above A`).
  - Every predicate is from the vocabulary in Section 2.
  - **Only one `ordered_triples` row per object, and its `"object"` field is that
    object's *complete* supporter set** (a single string, or an array if bridging).
    If you find two separate rows for the same `subject`, merge them into one row with
    an array `"object"` — unless one of the rows is spurious (it points to something A
    only had a `left`/`right`/`adjacent_to`/`front`/`back` triple to, never a true
    supporting relation — that is the Action Narrator lateral-relation bug; delete that
    row instead of merging it).
  - Every instance reference uses the exact indexed name assigned in Section 1 (no bare
    type name when quantity > 1, no instance mentioned under two different indices).
  - **Executability check — supporter-set ties only**: compare every row's `"object"`
    value (as a set) against every other row's. List any sets that are identical across
    2+ rows. For each such tied group, does every row in it carry a `"position"`, and
    are those values pairwise distinct? Rows whose supporter sets are unique (the common
    case, including most bridging rows) must **not** carry `"position"` — re-read the
    worked examples in Section 3 if unsure whether a given pair of bridging rows
    actually ties (same set) or merely overlaps (shares one member, different sets).
  - **The FINAL_JSON you are about to emit is itself schema-valid — this has been the
    single most common failure in testing, check it explicitly, entry by entry:** every
    entry in `ordered_triples` has exactly the keys `step`, `subject`, `predicate`,
    `object` (string or array of strings), and (when applicable) `position` — as real
    JSON key-value pairs, not as a bracket tuple copied from `REASONING_DRAFT`, and
    `step` values across all rows are unique and sequential with no repeats. Concretely:
    - **WRONG** (this exact mistake has recurred repeatedly — do not do this):
      `{ "subject": "B", "right", "A", "source": "relation_narrator" }` — after
      `"subject": "B",` the next field still needs its own `"key": value` — writing the
      predicate and object as bare comma-separated values, the way they appear in a
      `[B, right, A]` reasoning-draft bracket, is not valid JSON and breaks the entire
      FINAL_JSON block, not just this one entry.
    - **RIGHT**: `{ "subject": "B", "predicate": "right", "object": "A", "source":
      "relation_narrator" }`.
    This mistake shows up most often on the triples you write *quickly* late in a long
    `raw_triples` list (frequently the `left`/`right`/`adjacent_to` ones) — slow down
    and write every key explicitly for those exactly as you did for the `on` triples.
- Fix anything wrong and record what you changed (or state "no corrections needed").

---

## 4. FORBIDDEN

1. Do not output any numeric coordinate, distance, angle, or pose.
2. Do not use a predicate outside the Section 2 vocabulary.
3. Do not collapse the five roles into fewer than five labeled sections in `REASONING_DRAFT`.
4. Do not let a later role silently overwrite an earlier role's triples without the
   Triple Extractor step explicitly recording the change.
5. Do not add objects that are not in the part list, and do not drop objects that are.
6. Do not split one object's supporting relations across multiple `ordered_triples`
   rows — one object, one row, `"object"` as a string (single supporter) or array
   (multiple supporters). Never reuse a `step` number across rows.
7. Do not omit `"position"` when 2+ rows have the exact same supporter set (as a set) —
   the output must stay executable without needing to fall back on `raw_triples`.
8. Do not add `"position"` to a row whose supporter set is not tied with any other
   row's — a unique supporter combination (even one that partially overlaps another
   row's) already disambiguates on its own and has nothing left to add.

---

## 5. STRICT OUTPUT FORMAT

## REASONING_DRAFT

**Relation Narrator:**
- [triple], [triple], ...

**Image Narrator:**
- [triple], [triple], ...

**Base Searcher:**
- Anchor object: [name]. Justification: [one line].

**Action Narrator:**
- Ordered sequence: 1. [triple] 2. [triple] ...

**Triple Extractor:**
- Corrections: [list, or "none"].

## FINAL_JSON_START
{
  "anchor_object": "...",
  "raw_triples": [
    { "subject": "...", "predicate": "...", "object": "...", "source": "relation_narrator" },
    { "subject": "...", "predicate": "...", "object": "...", "source": "image_narrator" }
  ],
  "ordered_triples": [
    { "step": 1, "subject": "...", "predicate": "...", "object": "..." },
    { "step": 2, "subject": "SiblingA", "predicate": "attach_to", "object": "table", "position": "left" },
    { "step": 3, "subject": "SiblingB", "predicate": "attach_to", "object": "table", "position": "center" },
    { "step": 4, "subject": "SiblingC", "predicate": "attach_to", "object": "table", "position": "right" },
    { "step": 5, "subject": "BridgingPartOnAB", "predicate": "attach_to", "object": ["SiblingA", "SiblingB"] },
    { "step": 6, "subject": "BridgingPartOnBC", "predicate": "attach_to", "object": ["SiblingB", "SiblingC"] }
  ],
  "self_check_notes": "..."
}
## FINAL_JSON_END
