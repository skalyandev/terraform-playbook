{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "title": "EC2 CPU Utilization",
        "region": "${region}",
        "view": "timeSeries",
        "stat": "Average",
        "period": 300,
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "InstanceId",
            "${instance_id}"
          ]
        ]
      }
    },
    {
      "type": "metric",
      "x": 12,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "title": "Memory Utilization",
        "region": "${region}",
        "view": "timeSeries",
        "stat": "Average",
        "period": 300,
        "metrics": [
          [
            "CWAgent",
            "mem_used_percent",
            "InstanceId",
            "${instance_id}"
          ]
        ]
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 6,
      "width": 12,
      "height": 6,
      "properties": {
        "title": "Disk Utilization",
        "region": "${region}",
        "view": "timeSeries",
        "stat": "Average",
        "period": 300,
        "metrics": [
          [
            "CWAgent",
            "disk_used_percent",
            "InstanceId",
            "${instance_id}"
          ]
        ]
      }
    }
  ]
}
