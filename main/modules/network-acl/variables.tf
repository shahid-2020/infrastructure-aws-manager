variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ingress_rules" {
  type = list(object({
    rule_no    = number
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "egress_rules" {
  type = list(object({
    rule_no    = number
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
