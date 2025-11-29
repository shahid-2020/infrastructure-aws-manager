output "flow_log_id" {
  description = "The Flow Log ID"
  value       = aws_flow_log.vpc.id
}

output "log_group_name" {
  description = "The name of the CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.vpc_flow_logs.name
}

output "log_group_arn" {
  description = "The ARN of the CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.vpc_flow_logs.arn
}

output "iam_role_arn" {
  description = "The ARN of the IAM role used for VPC Flow Logs"
  value       = aws_iam_role.vpc_flow_logs.arn
}

