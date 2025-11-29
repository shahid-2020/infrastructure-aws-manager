variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the route table will be created."

  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "vpc_id cannot be empty."
  }
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block of the VPC. Used for the automatic local route (VPC internal traffic)."

  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "vpc_cidr_block must be a valid IPv4 CIDR block."
  }
}

variable "additional_routes" {
  type = list(object({
    cidr_block     = string
    gateway_id     = optional(string)
    nat_gateway_id = optional(string)
  }))
  default     = []
  description = "List of additional routes to add to the route table. Each route must specify either gateway_id (for Internet Gateway) or nat_gateway_id (for NAT Gateway), not both. The local route for VPC CIDR is automatically added."

  validation {
    condition = alltrue([
      for route in var.additional_routes : can(cidrhost(route.cidr_block, 0))
    ])
    error_message = "All cidr_block values in additional_routes must be valid IPv4 CIDR blocks."
  }

  validation {
    condition = alltrue([
      for route in var.additional_routes :
      (route.gateway_id != null) != (route.nat_gateway_id != null) ||
      (route.gateway_id == null && route.nat_gateway_id == null)
    ])
    error_message = "Each route must specify either gateway_id OR nat_gateway_id, not both, or neither if using other route targets."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the route table. Each tag must have a key and value."
}