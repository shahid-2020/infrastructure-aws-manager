variable "name" {
  type        = string
  description = "Name of the ECS cluster. Must be unique within the AWS account and region."

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 255
    error_message = "name must be between 1 and 255 characters."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.name))
    error_message = "name can only contain alphanumeric characters, hyphens, and underscores."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the ECS cluster."
}