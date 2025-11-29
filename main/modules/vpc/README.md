# VPC Module

This module creates a Virtual Private Cloud (VPC) with DNS support and default route tables, network ACLs, and security groups.

## Resources Created

- `aws_vpc` - The main VPC resource
- `aws_default_route_table` - Default route table for the VPC
- `aws_default_network_acl` - Default network ACL for the VPC
- `aws_default_security_group` - Default security group for the VPC

## Usage

```hcl
module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "main-vpc"
    Environment = "production"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `cidr_block` | `string` | The CIDR block for the VPC (e.g., 10.0.0.0/16) | Yes | - |
| `tags` | `map(string)` | A map of tags to assign to the VPC and related resources | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the VPC |
| `cidr_block` | The CIDR block of the VPC |

## Features

- DNS hostnames enabled
- DNS support enabled
- Default route table configured with local route
- Default network ACL configured
- Default security group configured

## Notes

- The VPC automatically creates default resources (route table, network ACL, security group)
- Default security group allows all egress and self-referencing ingress
- Default network ACL allows all traffic

