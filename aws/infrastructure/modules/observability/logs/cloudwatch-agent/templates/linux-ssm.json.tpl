{
  "schemaVersion": "2.2",
  "description": "Install Amazon CloudWatch Agent",

  "mainSteps": [
    {
      "action": "aws:configurePackage",
      "name": "installCloudWatchAgent",
      "inputs": {
        "name": "AmazonCloudWatchAgent",
        "action": "Install"
      }
    }
  ]
}
