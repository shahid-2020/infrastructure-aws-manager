variable "name" {
  type        = string
  description = "Name of the DB subnet group. Must be unique within the AWS account."

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 255
    error_message = "name must be between 1 and 255 characters."
  }
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the DB subnet group. Must include subnets in at least 2 availability zones."

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "subnet_ids must contain at least 2 subnets for high availability."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the DB subnet group."
}