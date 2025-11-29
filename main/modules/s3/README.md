# S3 Bucket Module

This module creates a secure S3 bucket with encryption, versioning, lifecycle policies, and public access blocking enabled.

## Resources Created

- `aws_s3_bucket` - The S3 bucket
- `aws_s3_bucket_ownership_controls` - Controls for bucket ownership
- `aws_s3_bucket_acl` - Bucket ACL configuration
- `aws_s3_bucket_public_access_block` - Public access blocking configuration
- `aws_s3_bucket_versioning` - Versioning configuration
- `aws_s3_bucket_lifecycle_configuration` - Lifecycle rules for noncurrent versions
- `aws_s3_bucket_server_side_encryption_configuration` - Server-side encryption

## Usage

```hcl
module "terraform_backend" {
  source = "./modules/s3"

  name = "terraform-common-backend"

  tags = {
    Name = "terraform-common-backend"
    Purpose = "Terraform state storage"
  }
}
```

## Input Variables

| Name | Type | Description | Required | Default |
|------|------|-------------|----------|---------|
| `name` | `string` | Name of the S3 bucket (must be globally unique) | Yes | - |
| `tags` | `map(string)` | A map of tags to assign to the S3 bucket | No | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The ID (name) of the S3 bucket |
| `arn` | The ARN of the S3 bucket |

## Security Features

- **Public Access Blocked**: All public access is blocked by default
- **Encryption**: AES256 server-side encryption enabled
- **Versioning**: Enabled to protect against accidental deletion
- **Lifecycle Rules**: Noncurrent versions expire after 3 days

## Notes

- Bucket names must be globally unique across all AWS accounts
- Bucket names must be between 3-63 characters
- Bucket names can only contain lowercase letters, numbers, hyphens, and periods
- The bucket is configured with ACL set to "private"
- Noncurrent versions are automatically deleted after 3 days to save costs

