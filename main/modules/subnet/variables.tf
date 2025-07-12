variable "vpc_id" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "auto_assign_public_ip" {
  type    = bool
  default = false
}

variable "name_prefix" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}