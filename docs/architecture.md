# AWS LLMOps Platform Architecture

## Target Architecture

User
↓
Application Load Balancer
↓
Amazon EKS
↓
FastAPI RAG Application
↓
Vector Search
↓
LLM

## Supporting AWS Services

- Amazon S3
- IAM
- Amazon ECR
- CloudWatch
- KMS

## Infrastructure

Infrastructure will be provisioned using Terraform.

## CI/CD

GitHub
↓
GitHub Actions
↓
Docker Build
↓
Amazon ECR
↓
Amazon EKS
