variable "security_group_id" {
  type        = string
  description = "The ID of the security group to add the egress rule to."
}

variable "security_group_name" {
  type        = string
  description = "Name of the security group (used for tagging)."
}

variable "cidr_ipv4" {
  type        = string
  description = "IPv4 CIDR block to allow traffic to. Use '0.0.0.0/0' for all IPv4 addresses, or a specific CIDR block for restricted access."

  validation {
    condition     = var.cidr_ipv4 == null || can(cidrhost(var.cidr_ipv4, 0))
    error_message = "cidr_ipv4 must be a valid IPv4 CIDR block or null."
  }
}

variable "cidr_ipv6" {
  type        = string
  description = "IPv6 CIDR block to allow traffic to. Use '::/0' for all IPv6 addresses, or null/empty string to disable IPv6."

  validation {
    condition     = var.cidr_ipv6 == null || var.cidr_ipv6 == "" || can(cidrhost(var.cidr_ipv6, 0))
    error_message = "cidr_ipv6 must be a valid IPv6 CIDR block, empty string, or null."
  }
}

variable "from_port" {
  type        = number
  description = "Starting port number. Use -1 for all ports (with protocol -1)."

  validation {
    condition     = var.from_port >= -1 && var.from_port <= 65535
    error_message = "from_port must be between -1 and 65535."
  }
}

variable "to_port" {
  type        = number
  description = "Ending port number. Use -1 for all ports (with protocol -1). Must be >= from_port."

  validation {
    condition     = var.to_port >= -1 && var.to_port <= 65535
    error_message = "to_port must be between -1 and 65535."
  }
}

variable "ip_protocol" {
  type        = string
  description = "IP protocol. Use 'tcp', 'udp', 'icmp', '-1' for all protocols, or protocol number."

  validation {
    condition     = contains(["tcp", "udp", "icmp", "-1", "6", "17", "1"], lower(var.ip_protocol)) || can(tonumber(var.ip_protocol))
    error_message = "ip_protocol must be a valid protocol name (tcp, udp, icmp) or number, or '-1' for all."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the security group egress rule."
}