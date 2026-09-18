## FINAL_JSON_START
{
  "objects": [
    { "id": 0, "object": "table", "edges": [] },
    { "id": 1, "object": "Cube", "edges": [{ "supporter": 0, "position": "left" }] },
    { "id": 2, "object": "Cube", "edges": [{ "supporter": 0, "position": "right" }] },
    { "id": 3, "object": "RectPrism", "edges": [{ "supporter": 1, "position": "left" }, { "supporter": 2, "position": "right" }] },
    { "id": 4, "object": "TriPrism", "edges": [{ "supporter": 3 }] }
  ]
}
## FINAL_JSON_END