# DB Subnet Group Module

This module creates a DB subnet group for RDS database instances. DB subnet groups allow you to specify which subnets your RDS instances can be launched in.

## Resources Created

- `aws_db_subnet_group` - The DB subnet group resource

## Usage

```hcl
module "db_subnet_group" {
  source = "./modules/db-subnet-group"

  name       = "main-private-db-subnet-group"
  subnet_ids = ["subnet-12345678", "subnet-87654321"]

  tags = {
    Name = "main-private-db-subnet-group"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `name` | `string` | Name of the DB subnet group (must be unique within AWS account) | Yes | - |
| `subnet_ids` | `list(string)` | List of subnet IDs (must include at least 2 subnets in different AZs) | Yes | - |
| `tags` | `map(string)` | A map of tags to assign to the DB subnet group | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the DB subnet group |

## Requirements

- At least 2 subnets in different availability zones for high availability
- Subnets must be in the same VPC
- Recommended to use private subnets for database instances

## Notes

- DB subnet groups are required for RDS instances (not required for RDS Aurora clusters in some cases)
- Subnets should be private subnets to keep databases secure
- The subnet group name must be unique within your AWS account and region

