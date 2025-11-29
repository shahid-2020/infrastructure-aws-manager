# Network ACL Module

This module creates a Network Access Control List (NACL) for a subnet with configurable ingress and egress rules. NACLs provide an additional layer of security as a stateless firewall.

## Resources Created

- `aws_network_acl` - The Network ACL resource
- `aws_network_acl_association` - Association between the NACL and subnet

## Usage

```hcl
module "subnet_nacl" {
  source = "./modules/network-acl"

  vpc_id    = "vpc-12345678"
  subnet_id = "subnet-12345678"
  
  ingress_rules = [
    {
      rule_no    = 100
      protocol   = "tcp"
      action     = "allow"
      cidr_block = "10.0.0.0/16"
      from_port  = 80
      to_port    = 80
    }
  ]
  
  egress_rules = [
    {
      rule_no    = 100
      protocol   = "-1"
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]

  tags = {
    Name = "public-subnet-nacl"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `vpc_id` | `string` | The ID of the VPC | Yes | - |
| `subnet_id` | `string` | The ID of the subnet to associate with | Yes | - |
| `ingress_rules` | `list(object)` | List of ingress rules | Yes | - |
| `egress_rules` | `list(object)` | List of egress rules | Yes | - |
| `tags` | `map(string)` | A map of tags to assign to the NACL | No | `{}` |

## Rule Object Structure

Each rule object must contain:
- `rule_no` (number): Rule number (1-32766, lower numbers evaluated first)
- `protocol` (string): Protocol (-1 for all, tcp, udp, icmp, or protocol number)
- `action` (string): Either "allow" or "deny"
- `cidr_block` (string): CIDR block to match
- `from_port` (number): Starting port (0 for ICMP, -1 for all)
- `to_port` (number): Ending port (0 for ICMP, -1 for all)

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID of the Network ACL |

## Notes

- NACLs are stateless (you must explicitly allow return traffic)
- Rules are evaluated in order (lowest rule_no first)
- Default NACL allows all traffic; custom NACLs deny all by default
- Each subnet must be associated with exactly one NACL

