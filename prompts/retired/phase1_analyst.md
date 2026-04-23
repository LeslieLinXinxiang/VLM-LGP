# TASK: Visual Spatial Analysis (Learn -> Reset -> Apply)

**Context**: You are an AI robot learning to see.
**Inputs**:
1.  **Teaching Examples**: Images with black footers, red crosses, and blue boxes.
2.  **Test Case**: A clean, multi-panel image (Panel 1, 2, 3) with NO markings.

---
### PHASE 1: KNOWLEDGE DISTILLATION (Report what you learned)

**Instruction**:
Look at the **Teaching Examples** first. Do not describe them. Instead, extract the **"Rules of Vision"**.
I want you to explicitly answer these questions in your output:
1.  **Visual Syntax**: What do the **Red Cross (+)** and **Blue Box [ ]** represent in the examples?
2.  **Anchor Logic**: Where is the coordinate center (0,0) located on the base?
3.  **Spatial Nuance**: Based on the footer text, what is the visual difference between being **"Directly Left/Right"** versus being **"Top-Left/Right"**? (Hint: Look at the horizontal alignment).

*Write this summary first. It proves you understand the logic.*

---
### PHASE 2: THE MEMORY FLUSH (Anti-Hallucination)

**CRITICAL INSTRUCTION**:
Now that you have learned the **Logic**, forget the **Data**.
*   The **Brown/Pink/Purple** cylinders in the examples **DO NOT EXIST** in the Test Case.
*   **Wipe your visual memory** of the specific objects in the Teaching Examples.
*   Look **ONLY** at the **Clean Test Image** now.

---
### PHASE 3: SEQUENTIAL ANALYSIS (The Test)

**Instruction**:
Analyze the **Clean Test Image** panel by panel. Use **Natural Language**.

**Step 1: Inventory Check (What is actually here?)**
*   Before describing positions, list the **Colors** of the cylinders you physically see in Panel 1. (If you don't see a color, don't list it).

**Step 2: Relative Description**
*   **Anchor**: Find the **Dark Square Handle** (Imagine the Red Cross is there).
*   **Target**: Look at each cylinder (Imagine the Blue Box is there).
*   **Describe**: Tell me where each cylinder sits relative to the handle.
    *   Use the **"Spatial Nuance"** you learned in Phase 1.
    *   Tell me if it is **aligned horizontally** (Directly Side) or **offset vertically** (Top/Bottom).
    *   *Style*: "The [Color] one is sitting..."

---
### REQUIRED OUTPUT FORMAT

**Part 1: My Learnings from Training Data**
"I have analyzed the examples and learned the following rules:
1.  The Red Cross marks... The Blue Box marks...
2.  The Anchor is located...
3.  The difference between 'Directly Side' and 'Corner' is..."

**Part 2: Analysis of Test Image**

**> Panel 1:**
"Visual Inventory: I see [Colors] cylinders.
Spatial Description:
*   The [Color] cylinder is [Natural Description]...
*   The [Color] cylinder is [Natural Description]..."

**> Panel 2:**
"Visual Inventory: ...
Spatial Description: ..."

**> Panel 3:**
"..."