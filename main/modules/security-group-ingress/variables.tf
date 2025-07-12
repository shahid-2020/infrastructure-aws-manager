variable "security_group_id" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "cidr_ipv4" {
  type = string
}

variable "cidr_ipv6" {
  type = string
}

variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}

variable "ip_protocol" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}