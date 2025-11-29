variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the Network ACL will be created."

  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "vpc_id cannot be empty."
  }
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to associate with the Network ACL. Each subnet must be associated with exactly one Network ACL."

  validation {
    condition     = length(var.subnet_id) > 0
    error_message = "subnet_id cannot be empty."
  }
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
  description = "List of ingress (inbound) rules for the Network ACL. Rules are evaluated in order (lowest rule_no first)."

  validation {
    condition     = length(var.ingress_rules) > 0
    error_message = "ingress_rules must contain at least one rule."
  }

  validation {
    condition = alltrue([
      for rule in var.ingress_rules : rule.rule_no >= 1 && rule.rule_no <= 32766
    ])
    error_message = "rule_no must be between 1 and 32766 for all ingress rules."
  }

  validation {
    condition = alltrue([
      for rule in var.ingress_rules : contains(["allow", "deny"], lower(rule.action))
    ])
    error_message = "action must be either 'allow' or 'deny' for all ingress rules."
  }

  validation {
    condition = alltrue([
      for rule in var.ingress_rules : can(cidrhost(rule.cidr_block, 0))
    ])
    error_message = "All cidr_block values in ingress_rules must be valid IPv4 CIDR blocks."
  }
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
  description = "List of egress (outbound) rules for the Network ACL. Rules are evaluated in order (lowest rule_no first)."

  validation {
    condition     = length(var.egress_rules) > 0
    error_message = "egress_rules must contain at least one rule."
  }

  validation {
    condition = alltrue([
      for rule in var.egress_rules : rule.rule_no >= 1 && rule.rule_no <= 32766
    ])
    error_message = "rule_no must be between 1 and 32766 for all egress rules."
  }

  validation {
    condition = alltrue([
      for rule in var.egress_rules : contains(["allow", "deny"], lower(rule.action))
    ])
    error_message = "action must be either 'allow' or 'deny' for all egress rules."
  }

  validation {
    condition = alltrue([
      for rule in var.egress_rules : can(cidrhost(rule.cidr_block, 0))
    ])
    error_message = "All cidr_block values in egress_rules must be valid IPv4 CIDR blocks."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the Network ACL. Each tag must have a key and value."
}
