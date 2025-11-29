variable "github_project_url" {
  type        = string
  description = "GitHub project URL used for tagging resources. Used in default tags for the AWS provider."

  validation {
    condition     = can(regex("^https?://", var.github_project_url)) || var.github_project_url == ""
    error_message = "github_project_url must be a valid URL starting with http:// or https://, or an empty string."
  }
}