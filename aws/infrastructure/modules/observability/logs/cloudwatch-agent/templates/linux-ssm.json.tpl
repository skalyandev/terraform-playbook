{
  "schemaVersion": "2.2",
  "description": "Install and configure Amazon CloudWatch Agent",

  "mainSteps": [
    {
      "action": "aws:runDocument",
      "name": "installCloudWatchAgent",
      "inputs": {
        "documentType": "SSMDocument",
        "documentPath": "AWS-ConfigureAWSPackage",
        "documentParameters": "{\"action\":\"Install\",\"name\":\"AmazonCloudWatchAgent\"}"
      }
    },
    {
      "action": "aws:runDocument",
      "name": "configureCloudWatchAgent",
      "inputs": {
        "documentType": "SSMDocument",
        "documentPath": "AmazonCloudWatch-ManageAgent",
        "documentParameters": "{\"action\":\"configure\",\"mode\":\"${mode}\",\"optionalConfigurationSource\":\"ssm\",\"optionalConfigurationLocation\":\"${ssm_parameter_name}\",\"optionalRestart\":\"${restart}\"}"
      }
    }
  ]
}
