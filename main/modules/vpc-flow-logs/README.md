# VPC Flow Logs Module

This module enables VPC Flow Logs for network traffic monitoring and security analysis. Flow logs capture information about IP traffic going to and from network interfaces in your VPC.

## Resources Created

- `aws_cloudwatch_log_group` - CloudWatch Log Group for storing flow logs
- `aws_iam_role` - IAM role for VPC Flow Logs service
- `aws_iam_role_policy` - IAM policy allowing logs to be written to CloudWatch
- `aws_flow_log` - VPC Flow Log resource

## Usage

```hcl
module "vpc_flow_logs" {
  source = "./modules/vpc-flow-logs"

  vpc_id         = "vpc-12345678"
  name_prefix    = "main"
  log_group_name = "/aws/vpc/main-flow-logs"
  
  log_retention_days = 30
  traffic_type       = "ALL"

  tags = {
    Name = "main-vpc-flow-logs"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `vpc_id` | `string` | The ID of the VPC to enable flow logs for | Yes | - |
| `name_prefix` | `string` | Prefix for naming resources | No | `"vpc-flow-logs"` |
| `log_group_name` | `string` | Name of the CloudWatch Log Group | Yes | - |
| `log_retention_days` | `number` | Number of days to retain logs | No | `30` |
| `traffic_type` | `string` | Type of traffic to log (ACCEPT, REJECT, ALL) | No | `"ALL"` |
| `kms_key_id` | `string` | KMS key ARN for log encryption | No | `null` |
| `tags` | `map(string)` | A map of tags to assign to resources | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `flow_log_id` | The Flow Log ID |
| `log_group_name` | The name of the CloudWatch Log Group |
| `log_group_arn` | The ARN of the CloudWatch Log Group |
| `iam_role_arn` | The ARN of the IAM role used for VPC Flow Logs |

## Features

- CloudWatch Logs integration for centralized logging
- Configurable log retention period
- Optional KMS encryption
- Automatic IAM role and policy creation
- Supports logging ACCEPT, REJECT, or ALL traffic

## Notes

- Flow logs can help with troubleshooting connectivity and security issues
- Valid log retention days: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653
- Traffic type ALL logs both accepted and rejected traffic

