## FINAL_JSON_START
{
  "objects": [
    {
      "id": 0,
      "object": "table",
      "edges": []
    },
    {
      "id": 1,
      "object": "RectPrism",
      "edges": [
        {
          "supporter": 0,
          "position": "left"
        }
      ]
    },
    {
      "id": 2,
      "object": "RectPrism",
      "edges": [
        {
          "supporter": 0,
          "position": "right"
        }
      ]
    },
    {
      "id": 3,
      "object": "Cube",
      "edges": [
        {
          "supporter": 1
        }
      ]
    },
    {
      "id": 4,
      "object": "Cube",
      "edges": [
        {
          "supporter": 2
        }
      ]
    },
    {
      "id": 5,
      "object": "RectPrism",
      "edges": [
        {
          "supporter": 3,
          "position": "left"
        },
        {
          "supporter": 4,
          "position": "right"
        }
      ]
    },
    {
      "id": 6,
      "object": "TriPrism",
      "edges": [
        {
          "supporter": 5
        }
      ]
    }
  ]
}
## FINAL_JSON_END