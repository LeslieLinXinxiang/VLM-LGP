#!/usr/bin/env python3
"""
Evaluate accuracy of FMB proposed method VLM outputs.

Checks:
1. JSON format validity
2. Object count matches category (3objs -> 4 objects including base)
3. Edge references are valid (supporter IDs exist)
4. Position labels are atomic (left/right/front/back or omitted)
5. No self-edges
"""
import argparse
import json
import re
from pathlib import Path
from typing import Any


def extract_json_from_md(md_content: str) -> dict[str, Any] | None:
    """Extract JSON between FINAL_JSON_START and FINAL_JSON_END markers."""
    match = re.search(
        r"## FINAL_JSON_START\n(.*?)\n## FINAL_JSON_END",
        md_content,
        re.DOTALL
    )
    if not match:
        return None
    json_str = match.group(1).strip()
    try:
        return json.loads(json_str)
    except json.JSONDecodeError:
        return None


def validate_json_structure(obj: dict, category: str) -> tuple[bool, list[str]]:
    """
    Validate JSON structure and content.
    Returns (is_valid, list_of_errors).
    """
    errors = []
    
    # Must be a dict with "objects" key
    if not isinstance(obj, dict) or "objects" not in obj:
        errors.append("Missing 'objects' key")
        return False, errors
    
    objects = obj["objects"]
    
    # Must be a list
    if not isinstance(objects, list):
        errors.append("'objects' is not a list")
        return False, errors
    
    if len(objects) == 0:
        errors.append("'objects' list is empty")
        return False, errors
    
    # First object must be base with id=0
    if objects[0].get("id") != 0 or objects[0].get("object") != "base":
        errors.append("First object must be id=0, name='base'")
    
    # Check expected object count from category
    if category in ["3objs", "4objs", "5objs"]:
        expected_count = int(category[0]) + 1  # +1 for base
        if len(objects) != expected_count:
            errors.append(f"Expected {expected_count} objects (category={category}), got {len(objects)}")
    
    # Validate IDs are sequential from 0
    expected_ids = list(range(len(objects)))
    actual_ids = [obj.get("id") for obj in objects]
    if actual_ids != expected_ids:
        errors.append(f"IDs should be {expected_ids}, got {actual_ids}")
    
    # Validate each object's edges
    for obj in objects:
        obj_id = obj.get("id")
        edges = obj.get("edges", [])
        
        if not isinstance(edges, list):
            errors.append(f"Object {obj_id}: 'edges' is not a list")
            continue
        
        for edge in edges:
            if not isinstance(edge, dict):
                errors.append(f"Object {obj_id}: edge is not a dict")
                continue
            
            supporter = edge.get("supporter")
            
            # Supporter must exist
            if supporter is None:
                errors.append(f"Object {obj_id}: edge missing 'supporter'")
                continue
            
            # Supporter must be valid ID
            if not isinstance(supporter, int) or supporter < 0 or supporter >= len(objects):
                errors.append(f"Object {obj_id}: invalid supporter ID {supporter}")
            
            # No self-edges
            if supporter == obj_id:
                errors.append(f"Object {obj_id}: self-edge detected (supporter={supporter})")
            
            # Position (if present) must be atomic
            if "position" in edge:
                pos = edge["position"]
                if pos not in {"left", "right", "front", "back"}:
                    errors.append(f"Object {obj_id}: invalid position '{pos}' (must be left/right/front/back)")
    
    is_valid = len(errors) == 0
    return is_valid, errors


def evaluate_sample(sample_path: Path, category: str) -> dict:
    """Evaluate all trials in a sample. Returns {'pass': int, 'fail': int, 'errors': list}."""
    results = {"pass": 0, "fail": 0, "errors": []}
    
    trials = sorted(sample_path.glob("trial_*.md"))
    
    for trial_file in trials:
        try:
            md_content = trial_file.read_text(encoding="utf-8")
            
            # Check if VLM output is present
            if "VLM Raw Output" not in md_content or "FINAL_JSON_START" not in md_content:
                results["fail"] += 1
                results["errors"].append(f"{trial_file.name}: No VLM output found")
                continue
            
            # Extract and validate JSON
            json_obj = extract_json_from_md(md_content)
            if json_obj is None:
                results["fail"] += 1
                results["errors"].append(f"{trial_file.name}: JSON extraction failed")
                continue
            
            is_valid, errs = validate_json_structure(json_obj, category)
            if is_valid:
                results["pass"] += 1
            else:
                results["fail"] += 1
                results["errors"].append(f"{trial_file.name}: {'; '.join(errs)}")
        
        except Exception as e:
            results["fail"] += 1
            results["errors"].append(f"{trial_file.name}: Exception: {e}")
    
    return results


def main():
    parser = argparse.ArgumentParser(description="Evaluate FMB accuracy")
    parser.add_argument(
        "--root",
        default="experiments/evaluations/VLM/gemini_proposed_method/FMB",
        help="Root directory of FMB evaluations"
    )
    args = parser.parse_args()
    
    root = Path(args.root).resolve()
    
    if not root.exists():
        print(f"Error: {root} does not exist")
        return 1
    
    overall = {"pass": 0, "fail": 0}
    errors_by_category = {}
    
    # Process categories (3objs, 4objs, 5objs)
    for category_dir in sorted(root.iterdir()):
        if not category_dir.is_dir():
            continue
        
        category = category_dir.name
        cat_results = {"pass": 0, "fail": 0, "samples": []}
        
        # Process samples
        for sample_dir in sorted(category_dir.iterdir()):
            if not sample_dir.is_dir():
                continue
            
            sample_id = sample_dir.name
            res = evaluate_sample(sample_dir, category)
            
            cat_results["pass"] += res["pass"]
            cat_results["fail"] += res["fail"]
            cat_results["samples"].append({
                "id": sample_id,
                "pass": res["pass"],
                "fail": res["fail"],
                "errors": res["errors"]
            })
        
        overall["pass"] += cat_results["pass"]
        overall["fail"] += cat_results["fail"]
        errors_by_category[category] = cat_results
    
    # Print summary
    total_trials = overall["pass"] + overall["fail"]
    accuracy = (overall["pass"] / total_trials * 100) if total_trials > 0 else 0
    
    print("\n" + "=" * 70)
    print("  FMB PROPOSED METHOD — ACCURACY EVALUATION")
    print("=" * 70)
    print(f"\nOVERALL RESULTS:")
    print(f"  Total Trials: {total_trials}")
    print(f"  Passed: {overall['pass']}")
    print(f"  Failed: {overall['fail']}")
    print(f"  Accuracy: {accuracy:.1f}%\n")
    
    # Per-category breakdown
    print("PER-CATEGORY BREAKDOWN:")
    for category in sorted(errors_by_category.keys()):
        cat_res = errors_by_category[category]
        cat_total = cat_res["pass"] + cat_res["fail"]
        cat_acc = (cat_res["pass"] / cat_total * 100) if cat_total > 0 else 0
        
        print(f"\n  {category}: {cat_res['pass']}/{cat_total} ({cat_acc:.1f}%)")
        
        for sample in cat_res["samples"]:
            s_total = sample["pass"] + sample["fail"]
            s_acc = (sample["pass"] / s_total * 100) if s_total > 0 else 0
            status = "✅" if sample["fail"] == 0 else "❌"
            print(f"    {status} {sample['id']}: {sample['pass']}/{s_total} ({s_acc:.1f}%)")
            
            if sample["errors"]:
                for err in sample["errors"][:2]:  # Show first 2 errors
                    print(f"       - {err[:80]}")
                if len(sample["errors"]) > 2:
                    print(f"       - ... and {len(sample['errors']) - 2} more errors")
    
    print("\n" + "=" * 70 + "\n")
    
    return 0 if overall["fail"] == 0 else 1


if __name__ == "__main__":
    exit(main())
