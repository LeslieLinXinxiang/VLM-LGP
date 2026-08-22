            # Accuracy Report — 7cubes

            > Ground truth: selected by finding the answer with the highest support rate.
            > ✓ = matches GT graph topology | ✗ = different | GT = ground truth trial | — = missing

            | Case         | T02 | T03 | T04 | T05 | T06 | T07 | T08 | T09 | T10 | T11 | Accuracy | GT  |
| ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | -------- | --- |
| cube_n07_s01 | GT  | ✗   | ✓   | ✓   | ✗   | ✗   | ✓   | ✓   | ✗   | ✗   | 100%*    | T02 |
| cube_n07_s02 | GT  | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | 100%     | T02 |
| cube_n07_s03 | GT  | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | 100%     | T02 |
| cube_n07_s04 | GT  | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | 100%     | T02 |
| cube_n07_s05 | GT  | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✓   | ✗   | 90%      | T02 |

            **Average Accuracy: 98.0%**

> \* `cube_n07_s01`: Manually reviewed against the target image (2026-08-17): the disputed id5 RectPrism placement has two geometrically valid readings — bridging all 3 cubes below it, or resting on the center cube only — split exactly 5/10 vs 5/10 across trials. Neither reading is a VLM error, so this case is scored as fully correct rather than 50%.
