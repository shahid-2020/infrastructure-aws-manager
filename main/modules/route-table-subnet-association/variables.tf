variable "route_table_id" {
  type        = string
  description = "The ID of the route table to associate with the subnets."

  validation {
    condition     = length(var.route_table_id) > 0
    error_message = "route_table_id cannot be empty."
  }
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to associate with the route table. Each subnet can only be associated with one route table at a time."

  validation {
    condition     = length(var.subnet_ids) > 0
    error_message = "subnet_ids must contain at least one subnet ID."
  }

  validation {
    condition     = length(var.subnet_ids) <= 100
    error_message = "subnet_ids cannot contain more than 100 subnets."
  }
}
