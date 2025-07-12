resource "aws_vpc_security_group_egress_rule" "ipv4" {
  security_group_id = var.security_group_id
  cidr_ipv4         = var.cidr_ipv4
  from_port         = var.from_port
  ip_protocol       = var.ip_protocol
  to_port           = var.to_port

  tags = merge(var.tags, { Name : "${var.security_group_name}-outbound" })
}

resource "aws_vpc_security_group_egress_rule" "ipv6" {
  security_group_id = var.security_group_id
  cidr_ipv6         = var.cidr_ipv6
  from_port         = var.from_port
  ip_protocol       = var.ip_protocol
  to_port           = var.to_port

  tags = merge(var.tags, { Name : "${var.security_group_name}-outbound" })
}