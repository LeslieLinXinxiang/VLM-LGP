import sys
import os

# Add FreeCAD libs to path
paths = ["/usr/lib/freecad/lib", "/usr/lib/freecad-python3/lib", "/usr/lib/freecad/Ext"]
for p in paths:
    if os.path.isdir(p) and p not in sys.path:
        sys.path.append(p)

import FreeCAD
import Part
import MeshPart
import Mesh

def split_and_export_step(step_file, out_dir):
    os.makedirs(out_dir, exist_ok=True)
    base_name = os.path.splitext(os.path.basename(step_file))[0]
    
    print(f"Processing {step_file}...")
    shape = Part.Shape()
    shape.read(step_file)
    
    solids = shape.Solids
    if not solids:
        print("No solids found. Attempting faces.")
        solids = [shape]
        
    doc = FreeCAD.newDocument("temp")
    
    for i, solid in enumerate(solids):
        print(f"  Converting solid/part {i+1}/{len(solids)}...")
        try:
            # Create a mesh from the shape solid
            mesh = MeshPart.meshFromShape(solid, 0.1, 0.1)
            
            # Put the mesh in the document to export it safely as OBJ
            mesh_obj = doc.addObject("Mesh::Feature", f"Mesh_{i}")
            mesh_obj.Mesh = mesh
            out_file = os.path.join(out_dir, f"{base_name}_part_{i+1}.obj")
            Mesh.export([mesh_obj], out_file)
            print(f"  -> Saved {out_file}")
            
            # Cleanup
            doc.removeObject(mesh_obj.Name)
        except Exception as e:
            print(f"  -> Failed to convert solid {i+1}: {e}")
            
    FreeCAD.closeDocument("temp")
    print(f"Done with {step_file}\n")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python split_step.py <step_file> <output_dir>")
        sys.exit(1)
        
    split_and_export_step(sys.argv[1], sys.argv[2])
