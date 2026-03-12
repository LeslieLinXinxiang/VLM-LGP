#!/usr/bin/env python3
"""
scripts/test_phase2_codegen.py

Test Phase2 codegen: reads Prompt1+Prompt2 outputs, generates .fol/.lgp files.

Usage:
    python scripts/test_phase2_codegen.py \
        [--phase1    generated/phase1_target_graph_img1_retry_marked.json] \
        [--p1-output generated/phase2_prompt1_output.json] \
        [--p2-output generated/phase2_prompt2_output.json] \
        [--out-dir   generated/phase2_codegen_run]
"""

import argparse
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from core.phase2_codegen import generate_step_files

DEFAULT_PHASE1   = "generated/phase1_target_graph_img1_retry_marked.json"
DEFAULT_P1_OUT   = "generated/phase2_prompt1_output.json"
DEFAULT_P2_OUT   = "generated/phase2_prompt2_output.json"
DEFAULT_OUT_DIR  = "generated/phase2_codegen_run"


def main():
    ap = argparse.ArgumentParser(description="Phase2 codegen: Prompt2 output → .fol/.lgp files")
    ap.add_argument("--phase1",    default=DEFAULT_PHASE1,  help="Phase1 JSON path")
    ap.add_argument("--p1-output", default=DEFAULT_P1_OUT,  help="Prompt1 output JSON")
    ap.add_argument("--p2-output", default=DEFAULT_P2_OUT,  help="Prompt2 output JSON")
    ap.add_argument("--out-dir",   default=DEFAULT_OUT_DIR, help="Output directory")
    args = ap.parse_args()

    phase1   = json.load(open(args.phase1,    encoding="utf-8"))
    p1_out   = json.load(open(args.p1_output, encoding="utf-8"))
    p2_out   = json.load(open(args.p2_output, encoding="utf-8"))

    print(f"[codegen] Selected strategy : {p2_out['selected']}")
    print(f"[codegen] Reason            : {p2_out.get('reason', 'N/A')}")
    print(f"[codegen] Output dir        : {args.out_dir}")
    print()

    files = generate_step_files(phase1, p1_out, p2_out, args.out_dir)

    print()
    print(f"[codegen] DONE — {len(files)} files generated in: {args.out_dir}")
    print()
    print("[codegen] File listing (in execution order):")
    for p in files:
        print(f"  {os.path.basename(p)}")


if __name__ == "__main__":
    main()
