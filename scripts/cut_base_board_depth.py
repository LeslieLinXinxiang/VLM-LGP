#!/usr/bin/env python3
from pathlib import Path
import argparse
import numpy as np


def load_obj(path):
    verts = []
    faces = []
    lines = []
    for line in Path(path).read_text().splitlines():
        if line.startswith('v '):
            verts.append(np.array(list(map(float, line.split()[1:4]))))
            lines.append(line)
        elif line.startswith('f '):
            faces.append([int(part.split('/')[0]) - 1 for part in line.split()[1:]])
            lines.append(line)
        else:
            lines.append(line)
    return np.stack(verts), faces, lines


def save_obj(path, verts, lines):
    out = []
    vi = 0
    for line in lines:
        if line.startswith('v '):
            v = verts[vi]
            out.append(f"v {v[0]:.6f} {v[1]:.6f} {v[2]:.6f}")
            vi += 1
        else:
            out.append(line)
    Path(path).write_text('\n'.join(out) + '\n')


def mesh_centroid(verts, faces):
    centroids = np.mean(verts[np.array(faces)], axis=1)
    v0 = verts[np.array(faces)[:, 0]]
    v1 = verts[np.array(faces)[:, 1]]
    v2 = verts[np.array(faces)[:, 2]]
    areas = np.linalg.norm(np.cross(v1 - v0, v2 - v0), axis=1) * 0.5
    return np.average(centroids, axis=0, weights=areas)


def main():
    parser = argparse.ArgumentParser(description='Cut depth from an OBJ by shifting vertices on one side of a plane.')
    parser.add_argument('input_obj', help='Source OBJ path')
    parser.add_argument('output_obj', help='Destination OBJ path')
    parser.add_argument('--axis', choices=['x', 'y', 'z'], default='z', help='Axis to cut along')
    parser.add_argument('--cut-side', choices=['positive', 'negative'], default='positive', help='Which side of the plane to reduce')
    parser.add_argument('--plane', type=float, default=0.05, help='Plane coordinate value (units same as OBJ)')
    parser.add_argument('--amount', type=float, default=0.035, help='Amount to remove from the selected side')
    parser.add_argument('--preserve-com', action='store_true', help='Translate the mesh after cutting to keep centroid in the same object coordinates')
    args = parser.parse_args()

    axis_index = {'x': 0, 'y': 1, 'z': 2}[args.axis]
    verts, faces, lines = load_obj(args.input_obj)
    orig_centroid = mesh_centroid(verts, faces)

    new_verts = verts.copy()
    side_sign = 1 if args.cut_side == 'positive' else -1
    mask = side_sign * new_verts[:, axis_index] > args.plane * side_sign
    new_verts[mask, axis_index] -= side_sign * args.amount

    if args.preserve_com:
        new_centroid = mesh_centroid(new_verts, faces)
        delta = orig_centroid - new_centroid
        new_verts += delta
        print('preserving centroid by translating mesh by', delta)

    new_centroid = mesh_centroid(new_verts, faces)
    print('orig centroid', orig_centroid)
    print('new centroid', new_centroid)
    print('delta', new_centroid - orig_centroid)

    save_obj(args.output_obj, new_verts, lines)
    print(f'Wrote modified OBJ to {args.output_obj}')


if __name__ == '__main__':
    main()
