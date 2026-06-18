# FMB S004 Defect Report: 14 Problematic Scene Files

## Executive Summary

**Total Defects Found:** 14 scenes (7 trials × 2 modes)  
**Root Cause:** Version mismatch between VLM output (MD/FINAL_JSON) and actual scene generation  
**Severity:** FATAL - All scenes missing expected objects  
**Affected Scenarios:** trial_02, trial_03, trial_04, trial_06, trial_07, trial_08, trial_09  
**Impact:** Cannot proceed with LGP execution for these scenes due to object count mismatch

---

## Problem Profile

### Pattern Summary

| Aspect | Detail |
|--------|--------|
| **Defect Type** | Object count mismatch + missing objects |
| **All problems in** | s004 scenario only (s001-s003 are clean ✓) |
| **Expected from MD** | 3 objects (nr mode) / 6 objects (r mode)  |
| **Actual in .g file** | 2 objects (nr mode) / 4 objects (r mode) |
| **Missing in nr mode** | `shape_2_3` (ALL 7 trials) |
| **Missing in r mode** | `shape_2_5, shape_2_6` (ALL 7 trials) |

### Root Cause Analysis

**Timeline of Evidence:**

1. **VLM MD Files created:** May 6, 2025 at 17:00-17:37
   - FINAL_JSON declares 3 Shape_2 objects
   - Example: trial_02.md has objects with id 0, 1, 2, 3 (three Shape 2s)

2. **Scene files regenerated:** June 2, 2025 at 23:41
   - Scene generation used spec: `fmb_3objs_s004_target_spec.json`
   - This spec defines only: `{"shape_2": 2}`
   - Expected output: 2 objects (nr) or 4 objects (r mode, 2×2)
   - Actual output: ✓ Correct per spec

3. **Version Mismatch:**
   - MD/FINAL_JSON was generated when s004 expected ~3 Shape_2 objects
   - Current spec only has 2 Shape_2 objects
   - This suggests the spec was changed AFTER MD generation, or MD was generated from a different spec version

**Meta File Evidence:**

From `trial_02_nr_meta.json`:
```json
{
  "scenario_id": "trial_02",
  "mode": "nr",
  "counts": {"shape_2": 2},
  "object_total": 2,
  "objects": [
    {"anon_id": "shape_2_1", ...},
    {"anon_id": "shape_2_2", ...}
  ]
}
```

From `trial_02_r_meta.json`:
```json
{
  "scenario_id": "trial_02",
  "mode": "r",
  "counts": {"shape_2": 4},
  "object_total": 4,
  "objects": [
    {"anon_id": "shape_2_1", ...},
    {"anon_id": "shape_2_2", ...},
    {"anon_id": "shape_2_3", ...},
    {"anon_id": "shape_2_4", ...}
  ]
}
```

---

## Detailed Defect Listing

### Group 1: Non-Redundant Mode (nr) - 7 Defects

#### Defect 1: trial_02_nr.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_02_nr.g`
- **MD Expectation:** 3 Shape_2 objects (id 1, 2, 3 in FINAL_JSON)
- **Scene File:** Only contains `shape_2_1` and `shape_2_2` (missing `shape_2_3`)
- **Count Mismatch:** Expected 3, Actual 2
- **Source Code Location:** Line 28 of trial_02_nr.g (ends abruptly)

#### Defect 2: trial_03_nr.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_03_nr.g`
- **MD Expectation:** 3 Shape_2 objects
- **Scene File:** Only contains `shape_2_1` and `shape_2_2`
- **Count Mismatch:** Expected 3, Actual 2
- **Status:** Same as trial_02_nr (systematic)

#### Defect 3: trial_04_nr.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_04_nr.g`
- **MD Expectation:** 3 Shape_2 objects
- **Scene File:** Only contains `shape_2_1` and `shape_2_2`
- **Count Mismatch:** Expected 3, Actual 2
- **Status:** Same as trial_02_nr

#### Defect 4: trial_06_nr.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_06_nr.g`
- **MD Expectation:** 3 Shape_2 objects
- **Scene File:** Only contains `shape_2_1` and `shape_2_2`
- **Count Mismatch:** Expected 3, Actual 2
- **Status:** Same as trial_02_nr

#### Defect 5: trial_07_nr.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_07_nr.g`
- **MD Expectation:** 3 Shape_2 objects
- **Scene File:** Only contains `shape_2_1` and `shape_2_2`
- **Count Mismatch:** Expected 3, Actual 2
- **Status:** Same as trial_02_nr

#### Defect 6: trial_08_nr.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_08_nr.g`
- **MD Expectation:** 3 Shape_2 objects
- **Scene File:** Only contains `shape_2_1` and `shape_2_2`
- **Count Mismatch:** Expected 3, Actual 2
- **Status:** Same as trial_02_nr

#### Defect 7: trial_09_nr.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_09_nr.g`
- **MD Expectation:** 3 Shape_2 objects
- **Scene File:** Only contains `shape_2_1` and `shape_2_2`
- **Count Mismatch:** Expected 3, Actual 2
- **Status:** Same as trial_02_nr

### Group 2: Redundant Mode (r) - 7 Defects

#### Defect 8: trial_02_r.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_02_r.g`
- **MD Expectation:** 6 Shape_2 objects (3 × 2 for redundancy)
- **Scene File:** Contains `shape_2_1`, `shape_2_2`, `shape_2_3`, `shape_2_4` (missing `shape_2_5`, `shape_2_6`)
- **Count Mismatch:** Expected 6, Actual 4
- **Missing Objects:** `shape_2_5`, `shape_2_6`

#### Defect 9: trial_03_r.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_03_r.g`
- **MD Expectation:** 6 Shape_2 objects
- **Scene File:** Contains `shape_2_1-4` only
- **Count Mismatch:** Expected 6, Actual 4
- **Missing Objects:** `shape_2_5`, `shape_2_6`

#### Defect 10: trial_04_r.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_04_r.g`
- **Missing Objects:** `shape_2_5`, `shape_2_6`
- **Count Mismatch:** Expected 6, Actual 4

#### Defect 11: trial_06_r.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_06_r.g`
- **Missing Objects:** `shape_2_5`, `shape_2_6`
- **Count Mismatch:** Expected 6, Actual 4

#### Defect 12: trial_07_r.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_07_r.g`
- **Missing Objects:** `shape_2_5`, `shape_2_6`
- **Count Mismatch:** Expected 6, Actual 4

#### Defect 13: trial_08_r.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_08_r.g`
- **Missing Objects:** `shape_2_5`, `shape_2_6`
- **Count Mismatch:** Expected 6, Actual 4

#### Defect 14: trial_09_r.g
- **File Path:** `experiments/scenes/fmb/3objs/s004/random_trials/trial_09_r.g`
- **Missing Objects:** `shape_2_5`, `shape_2_6`
- **Count Mismatch:** Expected 6, Actual 4

---

## Source Code: Scene Generation Logic

### File: `experiments/scripts/generate_fmb_scenes.py`

**Key Function: `expand_counts_for_redundancy()` (Lines 206-208)**
```python
def expand_counts_for_redundancy(target_counts: dict, mode: str) -> dict:
    factor = 2 if mode == "r" else 1
    return {k: int(v) * factor for k, v in target_counts.items()}
```

**Issue:** The function correctly applies redundancy doubling (2× for r mode), but uses the current spec which has `{"shape_2": 2}`.

**Target Spec Used: `experiments/configs/fmb_3objs_s004_target_spec.json`**
```json
{
  "counts": {
    "shape_2": 2
  },
  "vlm_gt_trial": 1,
  "vlm_vote_count": 3
}
```

**Expected in MD: `experiments/evaluations/VLM/gemini_proposed_method/FMB/3objs/004/trial_02.md`**
```json
{
  "objects": [
    {"id": 0, "object": "base", "edges": []},
    {"id": 1, "object": "Shape 2", "color": "green", ...},
    {"id": 2, "object": "Shape 2", "color": "yellow", ...},
    {"id": 3, "object": "Shape 2", "color": "red", ...}
  ]
}
```

The FINAL_JSON has 3 Shape 2 objects (IDs 1, 2, 3), but the spec only defines 2.

---

## Remediation Plan

### Option 1: Update Target Spec to Match VLM Output (RECOMMENDED)

**Problem being solved:** VLM correctly identified 3 Shape_2 objects; spec should be updated.

**Changes required:**

1. **Update `fmb_3objs_s004_target_spec.json`:**
   ```json
   {
     "counts": {
       "shape_2": 3
     },
     "vlm_gt_trial": 1,
     "vlm_vote_count": 3
   }
   ```

2. **Regenerate s004 scenes** using the corrected spec:
   ```bash
   cd /home/leslie/Projects/VLM_LGP
   source scripts/env.sh
   python3 experiments/scripts/generate_fmb_scenes.py --mags 3objs --scenarios 004 --force-regenerate
   ```

3. **Verify output:**
   - trial_02_nr.g should now contain 3 objects: `shape_2_1`, `shape_2_2`, `shape_2_3`
   - trial_02_r.g should now contain 6 objects: `shape_2_1` through `shape_2_6`
   - Meta files should update accordingly

4. **Re-run audit:**
   ```bash
   python3 experiments/scripts/scan_fmb_inputs.py --mags 3objs --scenarios 004
   ```

**Pros:**
- Aligns with VLM ground truth
- Maintains consistency across pipeline
- Fixes root cause

**Cons:**
- Changes experimental configuration
- May affect comparability with previous runs

### Option 2: Update MD/FINAL_JSON to Match Current Spec (NOT RECOMMENDED)

**Problem:** Manually edit all 7 trial MD files to have only 2 Shape_2 objects instead of 3.

**Why not recommended:**
- FINAL_JSON comes from VLM; modifying it breaks ground truth
- Undermines validation pipeline integrity
- Creates inconsistency in VLM output records

### Option 3: Add Manual Object Injection to Scenes

**Problem:** programmatically add the missing `shape_2_3` and `shape_2_5/6` objects to the existing .g files.

**Script approach:**
```python
# Pseudo-code to add missing objects to existing scenes
for scene_file in problematic_scenes:
    g_content = read_g_file(scene_file)
    # Extract last object's position and add new shape_2_X with offset
    new_obj_definition = generate_offset_object(last_obj, increment=0.1)
    g_content = insert_before_end(g_content, new_obj_definition)
    write_g_file(scene_file, g_content)
    update_meta_json(meta_file, new_count)
```

**Why not ideal:**
- Violates scene generation determinism (seed-based placement)
- Created objects may violate min_center_distance constraint
- Adds technical debt

---

## Recommended Solution: Option 1 (Update Spec + Regenerate)

### Step-by-step Implementation:

#### Step 1: Update the spec file
```bash
cat > /home/leslie/Projects/VLM_LGP/experiments/configs/fmb_3objs_s004_target_spec.json << 'EOF'
{
  "counts": {
    "shape_2": 3
  },
  "vlm_gt_trial": 1,
  "vlm_vote_count": 3
}
EOF
```

#### Step 2: Regenerate scenes for s004
```bash
cd /home/leslie/Projects/VLM_LGP
eval "$(conda shell.bash hook)" && conda activate vlm_jazzy
source scripts/env.sh
python3 experiments/scripts/generate_fmb_scenes.py --mags 3objs --scenarios 004
```

#### Step 3: Verify regeneration
```bash
# Check one corrected scene
grep -c "shape_2_" experiments/scenes/fmb/3objs/s004/random_trials/trial_02_nr.g
# Expected: 3

grep -c "shape_2_" experiments/scenes/fmb/3objs/s004/random_trials/trial_02_r.g
# Expected: 6
```

#### Step 4: Re-audit
```bash
python3 experiments/scripts/scan_fmb_inputs.py --mags 3objs --scenarios 004
# All 20 scenes should now pass (10 trials × 2 modes)
```

#### Step 5: Validate no new issues
```bash
# Check that s001-s003 still pass
python3 experiments/scripts/scan_fmb_inputs.py --mags 3objs
# Should show: 0 fatal issues
```

---

## Testing & Validation Checklist

- [ ] Target spec updated to `{"shape_2": 3}`
- [ ] Scenes regenerated successfully
- [ ] trial_02_nr.g contains exactly 3 shape_2 objects
- [ ] trial_02_r.g contains exactly 6 shape_2 objects (shape_2_1 through shape_2_6)
- [ ] Meta files updated with correct counts
- [ ] Audit re-run shows 0 fatal issues for s004
- [ ] s001-s003 still pass audit
- [ ] MD/FINAL_JSON correctly matches new scene counts
- [ ] No new safe_distance violations introduced
- [ ] Scene object naming follows contiguous index pattern

---

## Conclusion

**Root Cause:** Version mismatch between VLM output (3 objects expected) and scene generation spec (2 objects defined).

**Impact:** 14 scenes (7 trials × 2 modes) in s004 cannot proceed to LGP execution.

**Solution:** Update target spec to 3 Shape_2 objects and regenerate scenes.

**Timeline to Fix:** ~2 minutes for spec update + ~5 minutes for scene regeneration = ~7 minutes total.

**Recommendation:** Proceed with Option 1 (spec update + regeneration) to align with VLM ground truth and restore pipeline consistency.
