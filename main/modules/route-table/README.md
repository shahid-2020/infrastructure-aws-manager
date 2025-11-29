# Route Table Module

This module creates a custom route table for a VPC with a local route and optional additional routes (e.g., to Internet Gateway or NAT Gateway).

## Resources Created

- `aws_route_table` - The route table resource

## Usage

```hcl
module "public_route_table" {
  source = "./modules/route-table"

  vpc_id         = "vpc-12345678"
  vpc_cidr_block = "10.0.0.0/16"

  additional_routes = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = "igw-12345678"
    }
  ]

  tags = {
    Name = "main-public-route-table"
  }
}
```

With NAT Gateway:

```hcl
module "private_route_table" {
  source = "./modules/route-table"

  vpc_id         = "vpc-12345678"
  vpc_cidr_block = "10.0.0.0/16"

  additional_routes = [
    {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = "nat-12345678"
    }
  ]

  tags = {
    Name = "main-private-route-table"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `vpc_id` | `string` | The ID of the VPC | Yes | - |
| `vpc_cidr_block` | `string` | The CIDR block of the VPC (used for local route) | Yes | - |
| `additional_routes` | `list(object)` | List of additional routes to add | No | `[]` |
| `tags` | `map(string)` | A map of tags to assign to the route table | No | `{}` |

## Route Object Structure

Each route in `additional_routes` can have:
- `cidr_block` (string, required): The destination CIDR block
- `gateway_id` (string, optional): Internet Gateway ID for public routes
- `nat_gateway_id` (string, optional): NAT Gateway ID for private routes

**Note**: Each route must specify either `gateway_id` OR `nat_gateway_id`, not both.

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the route table |

## Notes

- A local route for the VPC CIDR block is automatically added (cannot be removed)
- Route tables are evaluated in order (most specific route first)
- You must explicitly associate subnets with route tables using the route-table-subnet-association module
- Each subnet must be associated with exactly one route table
- The default route table is created automatically when a VPC is created

