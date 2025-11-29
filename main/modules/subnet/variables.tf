variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the subnets will be created."
}

variable "cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for the subnets. The number of CIDR blocks must match the number of availability zones."

  validation {
    condition     = length(var.cidr_blocks) > 0 && length(var.cidr_blocks) <= 6
    error_message = "cidr_blocks must contain between 1 and 6 CIDR blocks."
  }

  validation {
    condition = alltrue([
      for cidr in var.cidr_blocks : can(cidrhost(cidr, 0))
    ])
    error_message = "All CIDR blocks must be valid IPv4 CIDR blocks."
  }
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones where subnets will be created. Length must match cidr_blocks. Note: Validation ensures count matches in the module's locals."

  validation {
    condition     = length(var.availability_zones) > 0 && length(var.availability_zones) <= 6
    error_message = "availability_zones must contain between 1 and 6 availability zones."
  }
}

variable "auto_assign_public_ip" {
  type        = bool
  default     = false
  description = "Whether to automatically assign public IP addresses to instances launched in these subnets. Set to true for public subnets."
}

variable "name_prefix" {
  type        = string
  default     = ""
  description = "Prefix to add to subnet names. Used for naming convention."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the subnets."
}