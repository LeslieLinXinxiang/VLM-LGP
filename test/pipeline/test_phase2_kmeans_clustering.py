#!/usr/bin/env python3
"""
Deprecated compatibility shim.

The isolated graph-clustering test lives at:
  test/graph_clustering/test_kmeans_clustering.py

This file is kept only to avoid breaking old local commands.
"""

import os
import runpy


ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
TARGET = os.path.join(ROOT_DIR, "test", "graph_clustering", "test_kmeans_clustering.py")


if __name__ == "__main__":
  runpy.run_path(TARGET, run_name="__main__")
