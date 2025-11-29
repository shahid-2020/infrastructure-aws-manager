variable "name" {
  type        = string
  description = "Name of the S3 bucket. Must be globally unique and comply with S3 bucket naming rules."

  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 63
    error_message = "S3 bucket name must be between 3 and 63 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.name)) || can(regex("^[a-z0-9]+$", var.name))
    error_message = "S3 bucket name must start and end with a lowercase letter or number, and can only contain lowercase letters, numbers, hyphens, and periods."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the S3 bucket."
}