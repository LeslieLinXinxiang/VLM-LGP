import os
import sys
import argparse
import trimesh
import coacd
import numpy as np

def decompose(input_file, output_dir=None, threshold=0.05, max_convex_hull=100, preprocess_mode="manifold"):
    """
    Decomposes a concave mesh into multiple convex parts using CoACD.
    """
    if not os.path.exists(input_file):
        print(f"Error: Input file {input_file} not found.")
        return

    # Load mesh
    print(f"Loading mesh: {input_file}")
    mesh = trimesh.load(input_file)
    if isinstance(mesh, trimesh.Scene):
        mesh = mesh.dump(concatenate=True)

    # Run CoACD
    print(f"Running CoACD (threshold={threshold}, max_convex_hull={max_convex_hull}, preprocess={preprocess_mode})...")
    # preprocess_mode can be 'auto', 'manifold', 'direct'
    # 'manifold' is generally best for simulation stability
    coacd_mesh = coacd.Mesh(mesh.vertices, mesh.faces)
    parts = coacd.run_coacd(
        coacd_mesh, 
        threshold=threshold, 
        max_convex_hull=max_convex_hull,
        preprocess_mode=preprocess_mode
    )

    if not parts:
        print("Error: CoACD failed to produce any parts.")
        return

    # Prepare output directory
    if output_dir is None:
        output_dir = os.path.dirname(input_file)
    
    os.makedirs(output_dir, exist_ok=True)
    
    base_name = os.path.splitext(os.path.basename(input_file))[0]
    
    asset_snippets = []
    body_snippets = []
    
    print(f"Saving {len(parts)} convex parts to {output_dir}")
    for i, (v, f) in enumerate(parts):
        part_name = f"{base_name}_{i}"
        part_file = os.path.join(output_dir, f"{part_name}.obj")
        
        # Create trimesh object for saving
        part_mesh = trimesh.Trimesh(vertices=v, faces=f)
        part_mesh.export(part_file)
        
        # Generate XML snippets
        asset_snippets.append(f'<mesh name="{part_name}" file="{part_name}.obj"/>')
        body_snippets.append(f'<geom class="workpiece" type="mesh" mesh="{part_name}"/>')

    print("\n" + "="*30)
    print("MUJOCO XML SNIPPETS")
    print("="*30)
    print("\n--- <asset> section ---")
    for s in asset_snippets:
        print(s)
    
    print("\n--- <body> section ---")
    for s in body_snippets:
        print(s)
    print("="*30 + "\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Decompose a mesh into convex parts for MuJoCo.")
    parser.add_argument("input", help="Input OBJ/STL file")
    parser.add_argument("--output_dir", help="Output directory (default: same as input)")
    parser.add_argument("--threshold", type=float, default=0.05, help="CoACD threshold (default: 0.05)")
    parser.add_argument("--max_convex_hull", type=int, default=100, help="Maximum convex hulls (default: 100)")
    parser.add_argument("--preprocess", choices=["auto", "manifold", "direct"], default="manifold", 
                        help="Preprocessing mode (default: manifold)")
    
    args = parser.parse_args()
    decompose(args.input, args.output_dir, args.threshold, args.max_convex_hull, args.preprocess)
