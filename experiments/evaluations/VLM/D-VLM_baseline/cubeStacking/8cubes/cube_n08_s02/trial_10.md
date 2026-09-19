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
          "position": "center"
        }
      ]
    },
    {
      "id": 3,
      "object": "RectPrism",
      "edges": [
        {
          "supporter": 0,
          "position": "right"
        }
      ]
    },
    {
      "id": 4,
      "object": "RectPrism",
      "edges": [
        {
          "supporter": 2
        }
      ]
    },
    {
      "id": 5,
      "object": "Cube",
      "edges": [
        {
          "supporter": 4,
          "position": "left"
        }
      ]
    },
    {
      "id": 6,
      "object": "Cube",
      "edges": [
        {
          "supporter": 4,
          "position": "right"
        }
      ]
    },
    {
      "id": 7,
      "object": "RectPrism",
      "edges": [
        {
          "supporter": 5
        },
        {
          "supporter": 6
        }
      ]
    },
    {
      "id": 8,
      "object": "TriPrism",
      "edges": [
        {
          "supporter": 7
        }
      ]
    }
  ]
}
## FINAL_JSON_END