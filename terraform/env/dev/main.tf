terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  profile = "terraform-lab"
}

# VPC module
module "vpc" {
  source = "../../modules/vpc"

  project_name = "aws-llmops-dev"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
}

# S3 module
module "s3" {
  source = "../../modules/s3"

  bucket_name = "pooja-llmops-documents-2026-3547"
  project_name = "aws-llmops-dev"
}

# IAM module
module "iam" {
  source = "../../modules/iam"

  project_name = "aws-llmops-dev"
  bucket_arn = module.s3.bucket_arn
}

# Latest Amazon Linux 2023 AMI in Mumbai
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["137112412989"]

  filter {
    name = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  filter {
    name = "state"
    values = ["available"]
  }
}

# Set this to your public IP followed by /32 before applying.
variable "admin_cidr" {
  description = "Your public IP address in CIDR notation, for SSH access"
  type = string
}

# Security group for the EC2 instance
resource "aws_security_group" "app" {
  name = "aws-llmops-dev-ec2-sg"
  description = "Restricted SSH access for the LLMOps EC2 instance"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "SSH from administrator IP only"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  egress {
    description = "Allow outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws-llmops-dev-ec2-sg"
    Project = "aws-llmops-dev"
    Environment = "dev"
  }
}

# EC2 application server
resource "aws_instance" "app" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id = module.vpc.public_subnet_id
  vpc_security_group_ids = [aws_security_group.app.id]
  iam_instance_profile = module.iam.app_instance_profile_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted = true
    delete_on_termination = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  tags = {
    Name = "aws-llmops-dev-app"
    Project = "aws-llmops-dev"
    Environment = "dev"
  }
}

output "ec2_instance_id" {
  description = "ID of the LLMOps application EC2 instance"
  value = aws_instance.app.id
}

output "ec2_public_ip" {
  description = "Public IP of the LLMOps application EC2 instance"
  value = aws_instance.app.public_ip
}

