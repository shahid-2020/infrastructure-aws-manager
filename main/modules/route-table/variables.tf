variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "additional_routes" {
  type = list(object({
    cidr_block     = string
    gateway_id     = optional(string)
    nat_gateway_id = optional(string)
  }))

  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}