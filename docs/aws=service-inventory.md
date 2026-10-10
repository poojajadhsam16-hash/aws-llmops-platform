# AWS Service Inventory

| Service | Purpose | Planned stage |
|---|---|---|
| VPC | Network isolation | Infrastructure |
| EC2 | Supporting compute where required | Infrastructure |
| EKS | Kubernetes workloads | Platform |
| ECR | Container images | CI/CD |
| S3 | Knowledge-base documents | RAG |
| IAM | Access control | Security |
| KMS | Encryption keys | Security |
| CloudWatch | Logs, metrics and alarms | Monitoring |
| ALB | Application traffic routing | Deployment |
| Terraform | Infrastructure as code | Infrastructure |
| GitHub Actions | Automated pipeline | CI/CD |

## Cost and Security Notes

- AWS resources will only be created when required.
- Review the estimated cost before provisioning.
- Avoid exposing administrative endpoints to the internet.
- Never commit credentials or secret values.
- Delete or destroy billable lab resources when finished.
- Validate resource deletion and remaining charges after teardown.

## Current Status

Architecture documented.
AWS infrastructure not yet provisioned.

