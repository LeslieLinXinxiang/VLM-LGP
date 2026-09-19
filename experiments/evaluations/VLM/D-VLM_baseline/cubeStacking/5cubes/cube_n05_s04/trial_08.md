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
      "object": "Long RectPrism",
      "edges": [
        {
          "supporter": 0
        }
      ]
    },
    {
      "id": 2,
      "object": "RectPrism",
      "edges": [
        {
          "supporter": 1
        }
      ]
    },
    {
      "id": 3,
      "object": "Cube",
      "edges": [
        {
          "supporter": 2,
          "position": "left"
        }
      ]
    },
    {
      "id": 4,
      "object": "Cube",
      "edges": [
        {
          "supporter": 2,
          "position": "right"
        }
      ]
    },
    {
      "id": 5,
      "object": "RectPrism",
      "edges": [
        {
          "supporter": 3
        },
        {
          "supporter": 4
        }
      ]
    }
  ]
}
## FINAL_JSON_END