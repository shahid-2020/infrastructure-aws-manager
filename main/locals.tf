locals {
  cidr_block          = "10.0.0.0/16"
  public_cidr_blocks  = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  private_cidr_blocks = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
  ingress_rules = [
    {
      rule_no    = 100
      protocol   = "-1"
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
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
}
