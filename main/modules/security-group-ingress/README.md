# Security Group Ingress Module

This module adds an ingress (inbound) rule to an existing security group for both IPv4 and IPv6 traffic.

## Resources Created

- `aws_vpc_security_group_ingress_rule` (IPv4) - Ingress rule for IPv4 traffic
- `aws_vpc_security_group_ingress_rule` (IPv6) - Ingress rule for IPv6 traffic

## Usage

```hcl
module "ssh_ingress" {
  source = "./modules/security-group-ingress"

  security_group_id   = "sg-12345678"
  security_group_name = "web-servers-sg"
  from_port           = 22
  to_port             = 22
  ip_protocol         = "TCP"
  cidr_ipv4           = "10.0.0.0/16"
  cidr_ipv6           = null

  tags = {
    Name = "ssh-ingress-rule"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `security_group_id` | `string` | The ID of the security group to add the rule to | Yes | - |
| `security_group_name` | `string` | Name of the security group (used for tagging) | Yes | - |
| `cidr_ipv4` | `string` | IPv4 CIDR block to allow traffic from | Yes | - |
| `cidr_ipv6` | `string` | IPv6 CIDR block to allow traffic from (null to disable) | Yes | - |
| `from_port` | `number` | Starting port number (-1 for all ports) | Yes | - |
| `to_port` | `number` | Ending port number (-1 for all ports) | Yes | - |
| `ip_protocol` | `string` | IP protocol (tcp, udp, icmp, -1, or protocol number) | Yes | - |
| `tags` | `map(string)` | A map of tags to assign to the rule | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `ipv4_rule_id` | The ID of the IPv4 ingress rule |
| `ipv6_rule_id` | The ID of the IPv6 ingress rule |

## Notes

- Ports range from -1 (all ports) to 65535
- Use `-1` for protocol and ports to allow all traffic
- Common protocols: TCP (6), UDP (17), ICMP (1)
- IPv6 rule is only created if `cidr_ipv6` is not null or empty

