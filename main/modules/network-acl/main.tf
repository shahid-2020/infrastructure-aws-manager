resource "aws_network_acl" "this" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      rule_no    = ingress.value["rule_no"]
      protocol   = ingress.value["protocol"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      rule_no    = egress.value["rule_no"]
      protocol   = egress.value["protocol"]
      action     = egress.value["action"]
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]
    }
  }

  tags = var.tags
}

resource "aws_network_acl_association" "this" {
  subnet_id      = var.subnet_id
  network_acl_id = aws_network_acl.this.id
}
