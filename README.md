# AWS Cloud Platform + AI/LLMOps

Production-style RAG platform built on AWS.

## Project Goal

Build and operate a production-style Retrieval-Augmented Generation
(RAG) platform using:

- AWS
- Terraform
- Docker
- Kubernetes
- Amazon EKS
- Amazon ECR
- FastAPI
- GitHub Actions
- CloudWatch
- IAM
- LLMOps

## Architecture

The platform will eventually include:

User
→ ALB
→ EKS
→ FastAPI RAG Service
→ Vector Search
→ LLM

Supporting services:

- Amazon S3
- IAM
- CloudWatch
- ECR
- Terraform
- GitHub Actions

## Project Status

Day 1 — Project initialization

## Learning Goals

1. AWS Platform Engineering
2. Infrastructure as Code
3. Kubernetes/EKS
4. CI/CD
5. RAG
6. LLMOps
7. Monitoring

**Current Project Status**
Project Overview
The AWS LLMOps Platform demonstrates a cloud-hosted application using FastAPI, Docker, AWS EC2, Amazon S3, IAM, and Terraform.

**Infrastructure**
AWS Region: Asia Pacific (Mumbai) — ap-south-1
Compute: Amazon EC2
Application: FastAPI
Containerization: Docker
Storage: Amazon S3
Infrastructure as Code: Terraform
Application endpoint: /
Health endpoint: /health
Retrieval endpoint: /rag
LLM endpoint: /ask
Validation Results
Component	Status
FastAPI application	Verified
Health endpoint	Working
RAG context retrieval	Working
EC2 IAM role and S3 object listing	Verified
Ollama model inference	Pending memory troubleshooting
CloudWatch CPU monitoring	Pending verification
Known Issue
The llama3.2:1b model fails to load on the current EC2 instance because the available memory is insufficient for its CPU buffer allocation.

The /ask endpoint therefore returns an error during inference. The issue remains under investigation; the existing AWS infrastructure is being retained.

**Next Improvements**
Configure and verify CloudWatch monitoring.
Complete LLM inference validation.
Implement CI/CD automation.
Expand application tests and operational documentation.
Document troubleshooting procedures and deployment steps.
Security Notes
Keep S3 Block Public Access enabled.
Follow least-privilege IAM permissions.
Do not commit AWS credentials, access keys, or secrets to GitHub.
Do not expose the Ollama API port publicly.

9. Security
10. FinOps
