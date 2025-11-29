# Route Table Subnet Association Module

This module associates one or more subnets with a route table. Each subnet must be associated with exactly one route table to determine how traffic is routed.

## Resources Created

- `aws_route_table_association` - One or more associations (one per subnet)

## Usage

```hcl
module "public_subnet_route_association" {
  source = "./modules/route-table-subnet-association"

  route_table_id = "rtb-12345678"
  subnet_ids     = ["subnet-12345678", "subnet-87654321", "subnet-11111111"]
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `route_table_id` | `string` | The ID of the route table to associate with subnets | Yes | - |
| `subnet_ids` | `list(string)` | List of subnet IDs to associate with the route table | Yes | - |

## Outputs

This module does not export any outputs.

## Important Notes

- **One-to-One**: Each subnet can only be associated with one route table at a time
- **Automatic Replacement**: If you change a subnet's route table association, Terraform will automatically disassociate the old route table and associate the new one
- **Default Route Table**: If you don't explicitly associate a subnet with a route table, it uses the VPC's default route table
- **Common Use Cases**:
  - Associate public subnets with a route table that has an Internet Gateway route
  - Associate private subnets with a route table that has a NAT Gateway route
  - Create separate route tables for different subnet tiers or environments

## Best Practices

- Group subnets by routing requirements (public, private, database)
- Use descriptive route table names to indicate their purpose
- Ensure all subnets in a route table have the same routing requirements

