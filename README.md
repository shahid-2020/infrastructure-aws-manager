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
| [Terraform Plan](.github/workflows/terraform-pr-plan.yml) | On PRs to main | Shows planned changes |
| [Terraform Apply](.github/workflows/terraform-apply.yml) | After merge to main | Automatically deploys infrastructure |

### Required Secrets

Configure these secrets in your GitHub repository settings:

| Variable | Description | Required For |
|----------|-------------|--------------|
| `AWS_ACCESS_KEY_ID` | AWS IAM Access Key | Plan & Apply workflows |
| `AWS_SECRET_ACCESS_KEY` | AWS IAM Secret Key | Plan & Apply workflows |
| `TERRAFORM_BACKEND_BUCKET` | S3 bucket for Terraform state | Plan & Apply workflows |

### Pipeline Flow

```
PR Created → Validation → Plan → Review → Merge to Main → Apply
```

## Usage Guidelines

### Local Development

1. Clone the repository:
   ```bash
   git clone git@personal.github.com:shahid-2020/infrastructure-aws-manager.git
   cd infrastructure-aws-manager
   ```

2. Initialize Terraform:
   ```bash
   cd main
   terraform init