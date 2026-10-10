# Terraform Infrastructure

## Purpose

This directory contains Terraform configurations and
reusable modules for the AWS Cloud Platform + AI/LLMOps project.

## Planned Modules

- modules/vpc: VPC and subnet configuration
- modules/iam: IAM roles and policies
- modules/s3: S3 bucket and encryption configuration

## Environment

- environments/dev: Development environment configuration

## Working Approach

1. Review the Terraform configuration.
2. Run terraform fmt.
3. Run terraform init.
4. Run terraform validate.
5. Review terraform plan before applying.
6. Apply only after reviewing the expected changes.
7. Verify the deployed resources.
8. Destroy temporary lab resources when appropriate.

## Security

- Never commit AWS access keys or secret keys.
- Do not commit Terraform state files.
- Do not commit sensitive tfvars files.
- Use least-privilege permissions.
- Review resource costs before provisioning.

## Current Status

Repository structure initialized.
Infrastructure modules will be implemented in subsequent labs.

