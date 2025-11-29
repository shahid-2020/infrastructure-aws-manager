variable "subnet_id" {
  type        = string
  description = "The ID of the public subnet where the NAT Gateway will be placed. The subnet must have a route to an Internet Gateway."

  validation {
    condition     = length(var.subnet_id) > 0
    error_message = "subnet_id cannot be empty."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the NAT Gateway and Elastic IP. Each tag must have a key and value."
}
