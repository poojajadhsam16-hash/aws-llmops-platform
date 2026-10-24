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

**Docker Image and CI/CD**

**Published Docker Image**

The application Docker image is published to Docker Hub:

- Repository: "pooja3012/aws-llmops-platform"
- Tag: "latest"
- Architecture: "linux/amd64"

**Pull the image:**

docker pull pooja3012/aws-llmops-platform:latest

**CI/CD Pipeline**

GitHub Actions automates the following steps:

1. Run application tests.
2. Build the Docker image.
3. Publish the image to Docker Hub after a push to the "main" branch.
4. Build without publishing for pull requests.

**Infrastructure Safety**

The CI/CD workflow builds and publishes the image independently of the existing AWS infrastructure. Deployment to EC2 is not automated by this workflow.

**Local Docker Validation**

**Test Results**

Test| Result
Docker Hub image pull| Passed
Docker container startup| Passed
FastAPI health endpoint ("GET /health")| Passed
RAG retrieval endpoint ("GET /rag")| HTTP 200
LLM question-answering endpoint ("GET /ask")| HTTP 200
GitHub Actions CI tests| Passed
Docker image build and publish workflow| Passed in the verified run

**Validation Scope**

The application was tested locally using the published Docker Hub image. The RAG endpoint successfully retrieved relevant context, and the LLM endpoint returned an answer.

These results confirm local application functionality for the tested requests. They do not by themselves establish production readiness, load-test performance, or continuous deployment to EC2.

**Infrastructure Safety**

No AWS infrastructure changes were required for these local validation tests. Existing AWS resources and Terraform configuration are being retained.

CloudWatch Review — AWS LLMOps Platform

Date: 24 October 2026
Region: "ap-south-1" (Mumbai)
EC2 instance: "i-0177e7ee8eae72b62"

**Review results**

- CPU utilization: Pending review
- Network metrics: Pending review
- EC2 status-check metrics: Pending review
- Existing CloudWatch alarms: Pending review
- Existing dashboards: Pending review
- Existing log groups: Pending review
- Memory and disk metrics: Not confirmed

**Change and cost control**

- No new AWS resources created.
- No existing AWS infrastructure modified.
- No Terraform apply performed.
- No new monitoring agent or custom metrics enabled.

**Outcome**

Read-only CloudWatch review completed after the actual metric and alarm states have been recorded.


