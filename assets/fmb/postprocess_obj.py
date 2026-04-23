import os
import sys

def postprocess_obj(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()
    
    vertices = []
    other_lines = []
    
    for line in lines:
        if line.startswith('v '):
            parts = line.split()
            vertices.append([float(parts[1]), float(parts[2]), float(parts[3])])
        else:
            other_lines.append(line)
            
    if not vertices:
        return
        
    # Calculate bounding box
    mins = [min(v[i] for v in vertices) for i in range(3)]
    maxs = [max(v[i] for v in vertices) for i in range(3)]
    center = [(mins[i] + maxs[i]) / 2.0 for i in range(3)]
    
    # Scale (mm -> m) and Center
    scale = 0.001
    new_vertices = []
    for v in vertices:
        rescaled = [(v[i] - center[i]) * scale for i in range(3)]
        new_vertices.append(rescaled)
        
    # Write back
    with open(file_path, 'w') as f:
        f.write("# Rescaled and Centered by PostProcess\n")
        for v in new_vertices:
            f.write(f"v {v[0]:.6f} {v[1]:.6f} {v[2]:.6f}\n")
        f.writelines(other_lines)
    
    # Print piece and size
    size_x = (maxs[0] - mins[0]) * scale
    size_y = (maxs[1] - mins[1]) * scale
    size_z = (maxs[2] - mins[2]) * scale
    print(f"Processed {os.path.basename(file_path)}: size=[{size_x:.4f} {size_y:.4f} {size_z:.4f}]m")

if __name__ == "__main__":
    target_dirs = [
        "/home/leslie/Projects/VLM_LGP/assets/fmb/assembly1_parts",
        "/home/leslie/Projects/VLM_LGP/assets/fmb/assembly2_parts",
        "/home/leslie/Projects/VLM_LGP/assets/fmb/assembly3_parts"
    ]
    
    for d in target_dirs:
        if not os.path.exists(d): continue
        for f in os.listdir(d):
            if f.endswith('.obj'):
                postprocess_obj(os.path.join(d, f))
