{
  "widgets": [

    {
      "type": "metric",
      "x":0,
      "y":0,
      "width":12,
      "height":6,

      "properties": {

        "metrics":[

          [
            "CWAgent",
            "mem_used_percent",
            "InstanceId",
            "${instance_id}"
          ]

        ],


        "region":"${region}",

        "title":"Jenkins Memory Usage"

      }

    }

  ]
}
