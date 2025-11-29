# Security Group Module

This module creates an AWS Security Group within a VPC. Security groups act as virtual firewalls to control inbound and outbound traffic.

## Resources Created

- `aws_security_group` - The security group resource

## Usage

```hcl
module "web_security_group" {
  source = "./modules/security-group"

  name   = "web-servers"
  vpc_id = "vpc-12345678"

  tags = {
    Name = "web-servers-sg"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `name` | `string` | Name prefix for the security group (full name will be '{name}-sg') | Yes | - |
| `vpc_id` | `string` | The ID of the VPC where the security group will be created | Yes | - |
| `tags` | `map(string)` | A map of tags to assign to the security group | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the security group |
| `name` | The name of the security group |
| `arn` | The ARN of the security group |

## Notes

- Security groups are stateful: if you send a request from your instance, the response traffic is automatically allowed
- By default, security groups deny all inbound traffic and allow all outbound traffic
- Use security-group-ingress and security-group-egress modules to add rules
- Security group names must be unique within the VPC

