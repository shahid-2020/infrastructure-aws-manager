# NAT Gateway Module

This module creates a NAT Gateway with an Elastic IP address. NAT Gateways enable resources in private subnets to initiate outbound internet connections while remaining private.

## Resources Created

- `aws_eip` - Elastic IP address for the NAT Gateway
- `aws_nat_gateway` - The NAT Gateway resource

## Usage

```hcl
module "nat_gateway" {
  source = "./modules/nat-gateway"

  subnet_id = "subnet-12345678"

  tags = {
    Name = "main-nat-gateway"
    Environment = "production"
  }

  depends_on = [module.internet_gateway]
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `subnet_id` | `string` | The ID of the public subnet where the NAT Gateway will be placed | Yes | - |
| `tags` | `map(string)` | A map of tags to assign to the NAT Gateway and EIP | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the NAT Gateway |

## Important Notes

- **Placement**: NAT Gateways must be placed in a **public subnet** (with an Internet Gateway route)
- **High Availability**: For production, create NAT Gateways in multiple AZs and route traffic accordingly
- **Cost**: NAT Gateways incur hourly charges and data processing fees
- **Elastic IP**: An Elastic IP is automatically created and associated with the NAT Gateway
- **Dependencies**: Ensure the subnet has a route to an Internet Gateway before creating the NAT Gateway
- **Private Subnets**: After creating a NAT Gateway, add routes in private subnet route tables pointing 0.0.0.0/0 to the NAT Gateway

## Architecture Best Practice

For high availability in production:
1. Create NAT Gateways in multiple availability zones
2. Create separate route tables for each private subnet in each AZ
3. Route each private subnet's traffic to the NAT Gateway in the same AZ

