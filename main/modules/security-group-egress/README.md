# Security Group Egress Module

This module adds an egress (outbound) rule to an existing security group for both IPv4 and IPv6 traffic. Egress rules control what outbound traffic is allowed from resources associated with the security group.

## Resources Created

- `aws_vpc_security_group_egress_rule` (IPv4) - Egress rule for IPv4 traffic
- `aws_vpc_security_group_egress_rule` (IPv6) - Egress rule for IPv6 traffic

## Usage

```hcl
module "web_egress" {
  source = "./modules/security-group-egress"

  security_group_id   = "sg-12345678"
  security_group_name = "web-servers-sg"
  from_port           = 443
  to_port             = 443
  ip_protocol         = "TCP"
  cidr_ipv4           = "0.0.0.0/0"
  cidr_ipv6           = "::/0"

  tags = {
    Name = "https-egress-rule"
  }
}
```

Allow all outbound traffic:

```hcl
module "all_egress" {
  source = "./modules/security-group-egress"

  security_group_id   = module.security_group.id
  security_group_name = module.security_group.name
  from_port           = -1
  to_port             = -1
  ip_protocol         = "-1"
  cidr_ipv4           = "0.0.0.0/0"
  cidr_ipv6           = "::/0"
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `security_group_id` | `string` | The ID of the security group to add the rule to | Yes | - |
| `security_group_name` | `string` | Name of the security group (used for tagging) | Yes | - |
| `cidr_ipv4` | `string` | IPv4 CIDR block to allow traffic to | Yes | - |
| `cidr_ipv6` | `string` | IPv6 CIDR block to allow traffic to (null to disable) | Yes | - |
| `from_port` | `number` | Starting port number (-1 for all ports) | Yes | - |
| `to_port` | `number` | Ending port number (-1 for all ports) | Yes | - |
| `ip_protocol` | `string` | IP protocol (tcp, udp, icmp, -1, or protocol number) | Yes | - |
| `tags` | `map(string)` | A map of tags to assign to the egress rule | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the IPv4 egress rule |
| `arn` | The ARN of the IPv4 egress rule |

## Common Use Cases

- **Internet Access**: Allow outbound HTTPS (443) to access external APIs
- **Database Access**: Allow outbound to database port (e.g., 5432 for PostgreSQL) in specific CIDR
- **All Traffic**: Allow all outbound traffic (common for web servers)
- **Restricted Access**: Limit outbound traffic to specific CIDR blocks for security

## Notes

- Security groups are **stateful**: if you allow outbound traffic, the response is automatically allowed inbound
- Ports range from -1 (all ports) to 65535
- Use `-1` for protocol and ports to allow all traffic
- Common protocols: TCP (6), UDP (17), ICMP (1)
- IPv6 rule is only created if `cidr_ipv6` is not null or empty
- By default, security groups allow all outbound traffic, but explicit rules provide better security and documentation

## Security Best Practices

- Follow the principle of least privilege - only allow necessary outbound traffic
- Restrict egress to specific CIDR blocks when possible
- Use specific port ranges instead of allowing all ports
- Document the purpose of egress rules with tags

