# AWS Cloud Platform + AI/LLMOps Architecture

## 1. Project Objective

Build a production-style Retrieval-Augmented Generation (RAG)
application on AWS using infrastructure as code, containers,
Kubernetes, CI/CD, security and monitoring.

## 2. Application Architecture

User / Browser
      |
      v
Application Load Balancer
      |
      v
Amazon EKS
      |
      v
FastAPI RAG Application
      |
      +----> Vector Search
      |
      +----> LLM Integration
      |
      v
Grounded Response

## 3. AWS Network

- Amazon VPC
- Public subnets for internet-facing components where required
- Private subnets for application workloads
- Route tables and Internet Gateway
- NAT Gateway only if required for private outbound connectivity
- Security groups with restricted access

## 4. AWS Services

- Amazon EKS: Kubernetes platform
- Amazon ECR: Container image registry
- Amazon S3: Document storage
- IAM: Identity and permissions
- AWS KMS: Encryption-key management
- CloudWatch: Logs, metrics and alarms
- Application Load Balancer: Application traffic routing

## 5. Infrastructure as Code

Terraform will provision and manage the AWS infrastructure.

Planned components:

- VPC and subnets
- IAM roles and policies
- S3 bucket and encryption
- EKS cluster and supporting resources
- Monitoring configuration

## 6. CI/CD Workflow

GitHub
  |
  v
GitHub Actions
  |
  v
Test Application
  |
  v
Build Docker Image
  |
  v
Push Image to Amazon ECR
  |
  v
Deploy to Amazon EKS
  |
  v
Verify Application Health

## 7. Security

- Least-privilege IAM permissions
- Encryption at rest where required
- Secure secrets management
- Restricted network access
- No credentials committed to GitHub
- Application and dependency testing

## 8. Monitoring and Operations

- Application logs
- Container and cluster health
- Request latency and error rates
- CloudWatch alarms
- Resource tagging and cost monitoring

## 9. RAG Pipeline

### Document Ingestion

Documents
  -> Text Extraction
  -> Chunking
  -> Embeddings
  -> Vector Store

### User Query

Question
  -> Retrieval
  -> Relevant Context
  -> LLM
  -> Answer

## 10. Implementation Status

Current stage: Architecture design and documentation.

Infrastructure, application deployment, CI/CD and RAG
integration will be implemented in later project stages.

