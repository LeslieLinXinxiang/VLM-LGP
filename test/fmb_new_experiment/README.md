# new_fmb Preview Test

This folder is an isolated preview test for `assets/fmb/new_fmb`.

## Files

- `scene_new_fmb_preview.g`: standalone scene to visually inspect new meshes.
- `view_new_fmb.py`: opens the preview scene in the RAI viewer.
- `audit_new_fmb_assets.py`: checks OBJ/MTL linkage and center offsets.

## Run

Always run in project runtime shell:

```bash
source /home/leslie/anaconda3/etc/profile.d/conda.sh
conda activate vlm_jazzy
source scripts/env.sh
```

Asset audit:

```bash
python3 test/fmb_new_experiment/audit_new_fmb_assets.py
```

Viewer preview:

```bash
python3 test/fmb_new_experiment/view_new_fmb.py
```

## Notes

- This test does not modify main pipeline files.
- In RAI scenes, `color:[r g b a]` in `.g` is the most reliable way to control visible color.
- MTL is still useful as source metadata and for external DCC tools (Blender/MeshLab).
