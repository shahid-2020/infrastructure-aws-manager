variable "name" {
  type        = string
  description = "The domain name for the hosted zone (e.g., example.com). Do not include a trailing dot."

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 255
    error_message = "Domain name must be between 1 and 255 characters."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", var.name))
    error_message = "Domain name must be a valid DNS domain name format."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the Route 53 hosted zone. Each tag must have a key and value."
}