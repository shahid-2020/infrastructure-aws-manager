variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC. Must be a valid IPv4 CIDR block (e.g., 10.0.0.0/16)."

  validation {
    condition     = can(cidrhost(var.cidr_block, 0))
    error_message = "cidr_block must be a valid IPv4 CIDR block."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the VPC and related resources. Each tag must have a key and value."
}