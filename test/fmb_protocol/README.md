# FMB Protocol Input Templates

This folder stores minimal templates for single-modality FMB VLM binding.

## Files

- `fewshot/fewshot_manifest.json`: few-shot index with 3 recommended units.
- `task_01/sequence/`: ordered real-task images only.

## Usage Notes

1. Keep all sequence frames in grayscale-shaded rendering.
2. Keep camera fixed across sequence frames.
3. Build VLM payload in this order:
   - prompt markdown
   - few-shot blocks
   - actual task folder images in filename order
4. Validate output using Phase0-style schema keys.
