# TASK: Digitize Static Scene Description

**Role**: You are a Digital Twin Generator.
**Input**: A natural language report describing **current objects** visible on a base.
**Context**: You do NOT know about assembly steps. You only see a static snapshot.
**Output**: A strict JSON list representing the physical layout.

---
### 1. SEMANTIC SPATIAL MAPPING

**Goal**: Snap the description to the closest standard slot relative to the center handle.

**The 9 Valid Slots**:
`top_left`, `top_center`, `top_right`
`mid_left`, `center`, `mid_right`
`bottom_left`, `bottom_center`, `bottom_right`

*   *Rule*: "Directly Left/Right" -> **`mid_left`** / **`mid_right`**.
*   *Rule*: "Top/Back/Upper" -> **`top_...`** rows.
*   *Rule*: "Bottom/Front/Lower" -> **`bottom_...`** rows.

---
### 2. ABSTRACTION & FORMATTING RULES

**Rule A: Generic Objects**
*   Ignore specific colors. All cylinders are simply **`"object": "cylinder"`**.

**Rule B: Structure**
*   Always include the Base itself first.
*   All cylinders are placed on `"base"`.

---
### 3. STRICT OUTPUT SCHEMA

```json
{
  "layout": [
    // 1. Always start with the Container Base
    {
      "object": "base",
      "placed_on": "table",
      "at_slot": null
    },
    // 2. Generate one entry for EACH cylinder described in the report
    {
      "object": "cylinder",
      "placed_on": "base",
      "at_slot": "..." 
    }
  ]
}
```

**Corner Case:**
*   If the report says "I see no cylinders", return the list with **only** the base entry.

---
### 4. EXECUTE

**Input Report**:
(Paste the Analyst's output here)

**Generate JSON**:
```

---