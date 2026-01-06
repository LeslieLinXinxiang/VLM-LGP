# TASK: Visual Spatial Analysis (Reality Inspection)

**Context**: You are a Quality Control Robot checking the current state of the workspace.
**Inputs**:
1.  **Teaching Examples**: Images with black footers, red crosses, and blue boxes. (Use these ONLY to learn definitions).
2.  **Test Case**: A clean, single-view image of the current workspace.

---
### PHASE 1: CALIBRATION (Learn the Rules)

**Instruction**: Look at the Teaching Examples.
1.  **Anchor**: The Red Cross marks the **Dark Square Handle** (Center, 0,0).
2.  **Target**: The Blue Box marks the cylinder being described.
3.  **Definitions**:
    *   **"Top/Bottom"**: Means vertically offset (Higher/Lower) from the handle.
    *   **"Directly Left/Right"**: Means horizontally aligned (Level) with the handle.

---
### PHASE 2: INSPECTION (The Real Task)

**CRITICAL**: Forget the specific objects in the examples. Look **ONLY** at the **Clean Test Image**.

**Step 1: Inventory Check (Anti-Hallucination)**
*   List the **Colors** of the cylinders you PHYSICALLY SEE on the Light Grey Base.
*   *If the base is empty, state "I see no cylinders".*

**Step 2: Spatial Description**
*   **Locate Anchor**: Find the Dark Square Handle.
*   **Describe Targets**: For each cylinder found in Step 1, describe its position relative to the handle using **Natural Language**.
    *   Is it Left/Right?
    *   Is it Higher (Top), Lower (Bottom), or Level (Directly Side)?

---
### OUTPUT FORMAT

**1. Visual Inventory:**
"On the active base, I see [Number] cylinders: [List Colors]."

**2. Spatial Status:**
"
*   The [Color] cylinder is [Description]...
*   The [Color] cylinder is [Description]...
"