terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "terraform-lab"
}

# VPC module
module "vpc" {
  source = "../../modules/vpc"

  project_name       = "aws-llmops-dev"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
}

# S3 module
module "s3" {
  source = "../../modules/s3"

  bucket_name  = "pooja-llmops-documents-2026-3547"
  project_name = "aws-llmops-dev"
}

# IAM module
module "iam" {
  source = "../../modules/iam"

  project_name = "aws-llmops-dev"
  bucket_arn   = module.s3.bucket_arn
}

