# AWS Global Infrastructure Manager

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)

This Terraform project manages **global AWS infrastructure** components that serve as foundational resources across all environments and projects.

## Key Characteristics

🌍 **Global Scope**  
- Manages shared infrastructure resources
- Not tied to specific environments (dev/stage/prod)
- May include networking, security, logging, and other cross-cutting concerns

⚡ **Current Features**
- Core global infrastructure components
- Multi-region support
- Centralized networking foundations

🚧 **Planned Enhancements**
- IPv6 support (coming soon)
- Additional global services integration
- Enhanced security controls

## CI/CD Pipeline

### Workflow Structure

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| [Terraform Validation](.github/workflows/terraform-validation.yml) | On every PR/push | Validates syntax and formatting |
| [PR Plan](.github/workflows/terraform-pr-plan.yml) | PRs to main | Shows planned changes |
| [Apply Changes](.github/workflows/terraform-apply.yml) | Merge to main | Deploys infrastructure |

### Required Secrets

These secrets must be configured in your CI/CD environment:

| Variable | Description | Example |
|----------|-------------|---------|
| `AWS_ACCESS_KEY_ID` | AWS IAM Access Key | AKIAXXXXXXXXXXXXXXXX |
| `AWS_SECRET_ACCESS_KEY` | AWS IAM Secret Key | **************************************** |
| `AWS_DEFAULT_REGION` | Default AWS Region | us-east-1 |

## Usage Guidelines

### Local Development

1. Clone the repository
2. Initialize Terraform:
   ```bash
   cd main
   terraform init