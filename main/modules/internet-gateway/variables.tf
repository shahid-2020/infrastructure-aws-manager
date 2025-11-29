variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to attach the Internet Gateway to."

  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "vpc_id cannot be empty."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the Internet Gateway. Each tag must have a key and value."
}