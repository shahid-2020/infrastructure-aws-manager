module "terraform_backend" {
  source = "./modules/s3"

  name = "terraform-common-backend"
}