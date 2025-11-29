variable "name" {
  type        = string
  description = "Name prefix for the security group. The full name will be '{name}-sg'."

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 255
    error_message = "name must be between 1 and 255 characters."
  }
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the security group will be created."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the security group."
}