# Route53 Hosted Zone Module

This module creates an Amazon Route 53 hosted zone for DNS management. Route 53 hosted zones manage how traffic is routed for a domain.

## Resources Created

- `aws_route53_zone` - The Route 53 hosted zone resource

## Usage

```hcl
module "domain" {
  source = "./modules/route53"

  name = "example.com"

  tags = {
    Name = "example.com-zone"
    Environment = "production"
  }
}
```

For a private hosted zone (within a VPC):

```hcl
module "private_domain" {
  source = "./modules/route53"

  name = "internal.example.com"

  tags = {
    Name = "internal-zone"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `name` | `string` | The domain name for the hosted zone (e.g., example.com) | Yes | - |
| `tags` | `map(string)` | A map of tags to assign to the hosted zone | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `zone_id` | The hosted zone ID (used for creating DNS records) |
| `name_servers` | List of name servers to configure with your domain registrar |
| `arn` | The ARN of the hosted zone |

## Notes

- **Public vs Private**: By default, this creates a public hosted zone. To create a private hosted zone, you would need to add `vpc` blocks to the module
- **Domain Registration**: Creating a hosted zone does NOT register the domain name. You must register the domain separately
- **Name Servers**: After creation, Route 53 provides name server records that must be configured with your domain registrar
- **DNS Records**: Use the hosted zone ID to create A, AAAA, CNAME, and other DNS records
- **Cost**: Hosted zones have a small monthly fee per zone

## Example: Complete DNS Setup

```hcl
# 1. Create hosted zone
module "domain" {
  source = "./modules/route53"
  name   = "example.com"
}

# 2. Output name servers for domain registration
output "name_servers" {
  value = module.domain.name_servers
}

# 3. Output zone ID for creating DNS records
output "zone_id" {
  value = module.domain.zone_id
}

# 4. Configure name servers with your domain registrar
# 5. Use zone_id to create A, CNAME, MX, etc. records
```

## Limitations

- The current module implementation creates a basic public hosted zone
- For private hosted zones, additional VPC configuration would be required
- No DNS records are created automatically - use separate Route 53 record resources

