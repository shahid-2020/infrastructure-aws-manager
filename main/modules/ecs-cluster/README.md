# ECS Cluster Module

This module creates an Amazon Elastic Container Service (ECS) cluster with Container Insights enabled for monitoring.

## Resources Created

- `aws_ecs_cluster` - The ECS cluster resource

## Usage

```hcl
module "ecs_cluster" {
  source = "./modules/ecs-cluster"

  name = "production"

  tags = {
    Name        = "production-ecs-cluster"
    Environment = "production"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `name` | `string` | Name of the ECS cluster (must be unique within AWS account and region) | Yes | - |
| `tags` | `map(string)` | A map of tags to assign to the ECS cluster | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the ECS cluster |
| `arn` | The ARN of the ECS cluster |

## Features

- Container Insights enabled for enhanced monitoring and observability
- Automatically configured for both Fargate and EC2 launch types

## Notes

- Container Insights provides detailed metrics and logs for your containers
- Cluster names can contain alphanumeric characters, hyphens, and underscores
- An empty cluster can be created and services/tasks can be added later

