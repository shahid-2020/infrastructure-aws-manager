# AWS Manager (Global Infrastructure Management)

This Terraform project is responsible for managing **global infrastructure** resources, which may include networking, compute, storage, security, and other foundational components. The project focuses on creating and managing resources that are globally applicable and not tied to any specific environment or project.

## Important Notes

- **No environment-specific management**: This project **does not** maintain or manage resources for specific environments such as `test`, `staging`, or `production`. Instead, it manages global infrastructure components that are shared across environments.
- **Flexible Scope**: The scope of the project is not limited to networking but can include any resource that forms part of the global infrastructure.
- **Future Enhancements**: IPv6 support is not implemented at this time but is planned for future iterations.

## Required CI/CD Variables

The following variables must be configured in the CI/CD pipeline for successful deployment:

| Variable Name              | Visibility | Description                               |
|----------------------------|------------|-------------------------------------------|
| `AWS_ACCESS_KEY_ID`         | Expanded   | AWS Access Key ID for authentication      |
| `AWS_DEFAULT_REGION`        | Expanded   | Default AWS Region                        |
| `AWS_SECRET_ACCESS_KEY`     | Masked     | AWS Secret Access Key for authentication  |
| `TF_HTTP_PASSWORD`          | Masked     | Password for Terraform backend            |
| `TF_HTTP_USERNAME`          | Expanded   | Username for Terraform backend            |

Ensure that these variables are properly set in the CI environment.
