terraform {
  backend "s3" {
    bucket       = "terraform-common-backend"
    key          = "infrastructure-aws-manager/terraform.tfstate"
    use_lockfile = true
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}