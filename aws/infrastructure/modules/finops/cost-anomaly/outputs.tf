#########################################################
# COST ANOMALY OUTPUTS
#########################################################

output "cost_anomly_monitor_arn" {
  description = "ARN of the Cost Anomaly Detection monitor."
  value       = aws_ce_anomaly_monitor.this.arn
}

output "cost_anomly_monitor_id" {
  description = "ID of the Cost Anomaly Detection monitor."
  value       = aws_ce_anomaly_monitor.this.id
}

output "cost_anomly_subscription_arn" {
  description = "ARN of the Cost Anomaly Detection subscription."
  value       = aws_ce_anomaly_subscription.this.arn
}

output "cost_anomly_subscription_id" {
  description = "ID of the Cost Anomaly Detection subscription."
  value       = aws_ce_anomaly_subscription.this.id
}
