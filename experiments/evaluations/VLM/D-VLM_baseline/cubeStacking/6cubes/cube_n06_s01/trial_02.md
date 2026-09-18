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
          "supporter": 1,
          "position": "left"
        },
        {
          "supporter": 2,
          "position": "left"
        }
      ]
    },
    {
      "id": 5,
      "object": "RectPrism",
      "edges": [
        {
          "supporter": 2,
          "position": "right"
        },
        {
          "supporter": 3,
          "position": "right"
        }
      ]
    },
    {
      "id": 6,
      "object": "TriPrism",
      "edges": [
        {
          "supporter": 4,
          "position": "center"
        },
        {
          "supporter": 5,
          "position": "center"
        }
      ]
    }
  ]
}
## FINAL_JSON_END