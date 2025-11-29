# Subnet Module

This module creates one or more subnets within a VPC across multiple availability zones.

## Resources Created

- `aws_subnet` - One or more subnets based on the number of CIDR blocks provided

## Usage

```hcl
module "public_subnets" {
  source = "./modules/subnet"

  vpc_id             = "vpc-12345678"
  cidr_blocks        = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  auto_assign_public_ip = true
  name_prefix        = "main"
  
  tags = {
    Tier = "public"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `vpc_id` | `string` | The ID of the VPC where subnets will be created | Yes | - |
| `cidr_blocks` | `list(string)` | List of CIDR blocks for the subnets | Yes | - |
| `availability_zones` | `list(string)` | List of availability zones (must match CIDR blocks count) | Yes | - |
| `auto_assign_public_ip` | `bool` | Whether to automatically assign public IP addresses | No | `false` |
| `name_prefix` | `string` | Prefix for subnet names | No | `""` |
| `tags` | `map(string)` | A map of tags to assign to the subnets | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `ids` | List of subnet IDs |

## Validation

- Number of CIDR blocks must match number of availability zones
- CIDR blocks must be valid IPv4 CIDR notation
- Subnet count limited to 6 (AWS limit per availability zone)

## Notes

- Subnet names are automatically generated based on prefix, tier (public/private), and index
- Each subnet is created in a different availability zone for high availability

