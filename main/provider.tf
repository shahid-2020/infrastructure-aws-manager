provider "aws" {
  default_tags {
    tags = {
      Environment = "production"
      ManagedVia  = "Terraform"
      Project     = var.github_project_url
    }
  }
}