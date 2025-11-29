variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to enable flow logs for."
}

variable "name_prefix" {
  type        = string
  description = "Prefix for naming resources (log group, IAM role, etc.)."
  default     = "vpc-flow-logs"
}

variable "log_group_name" {
  type        = string
  description = "Name of the CloudWatch Log Group for VPC Flow Logs."

  validation {
    condition     = length(var.log_group_name) > 0 && length(var.log_group_name) <= 512
    error_message = "log_group_name must be between 1 and 512 characters."
  }
}

variable "log_retention_days" {
  type        = number
  description = "Number of days to retain logs in CloudWatch. Valid values: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, or 0 (never expire)."
  default     = 30

  validation {
    condition = contains([
      0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653
    ], var.log_retention_days)
    error_message = "log_retention_days must be a valid CloudWatch log retention value."
  }
}

variable "traffic_type" {
  type        = string
  description = "Type of traffic to log. Valid values: ACCEPT, REJECT, or ALL."
  default     = "ALL"

  validation {
    condition     = contains(["ACCEPT", "REJECT", "ALL"], upper(var.traffic_type))
    error_message = "traffic_type must be ACCEPT, REJECT, or ALL."
  }
}

variable "kms_key_id" {
  type        = string
  description = "The ARN of the KMS key to use for encrypting log data. If not specified, logs are encrypted with the default CloudWatch Logs encryption."
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the VPC Flow Logs resources."
}

