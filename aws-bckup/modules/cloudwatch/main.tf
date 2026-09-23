resource "aws_cloudwatch_log_group" "bastion" {

  name  = "/aws/ec2/${var.name}/bastion"
  
  retention_in_days = 30

  tags = var.tags

}


resource "aws_cloudwatch_metric_alarm" "high_cpu" {

  alarm_name          = "${var.name}-bastion-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = 300

  statistic = "Average"

  threshold = 80

  dimensions = {
    InstanceId = var.instance_id
  }
}
