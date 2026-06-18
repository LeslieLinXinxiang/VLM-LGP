#!/usr/bin/env python3
"""Run single real experiment for 8_cubes_nr."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

REAL_EXP_DIR = Path(__file__).resolve().parents[1]
if str(REAL_EXP_DIR) not in sys.path:
    sys.path.insert(0, str(REAL_EXP_DIR))

from _single_case_runner import CaseConfig, add_common_arguments, run_case


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Run 8_cubes_nr pipeline (scene+phase0+codegen+solver+export)")
    return add_common_arguments(parser).parse_args()


def main() -> int:
    args = parse_args()
    cfg = CaseConfig(
        name="8_cubes_nr",
        vlm_md_rel="experiments/evaluations/VLM/gemini_proposed_method/cubeStacking/8cubes/cube_n08_s02/trial_02.md",
        scene_rel="experiments/scenes/8cubes/s02/random_trials/trial_01_nr.g",
        out_dir=Path(__file__).resolve().parent,
    )
    return run_case(cfg, args)


if __name__ == "__main__":
    raise SystemExit(main())
