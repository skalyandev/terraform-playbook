{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/ApplicationELB",
            "RequestCount",
            "LoadBalancer",
            "${alb_suffix}"
          ]
        ],
        "region": "${region}",
        "title": "ALB Request Count"
      }
    }
  ]
}
