# Internet Gateway Module

This module creates an Internet Gateway and attaches it to a VPC. An Internet Gateway enables resources in public subnets to communicate with the internet.

## Resources Created

- `aws_internet_gateway` - The Internet Gateway resource

## Usage

```hcl
module "igw" {
  source = "./modules/internet-gateway"

  vpc_id = "vpc-12345678"

  tags = {
    Name = "main-igw"
    Environment = "production"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `vpc_id` | `string` | The ID of the VPC to attach the Internet Gateway to | Yes | - |
| `tags` | `map(string)` | A map of tags to assign to the Internet Gateway | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Internet Gateway |

## Notes

- An Internet Gateway is required for resources in public subnets to access the internet
- Only one Internet Gateway can be attached to a VPC at a time
- Internet Gateways are automatically redundant and highly available
- After creating an Internet Gateway, you need to add routes to your route tables pointing internet traffic (0.0.0.0/0) to the gateway
- Internet Gateways are free (no data transfer charges within the same region)

