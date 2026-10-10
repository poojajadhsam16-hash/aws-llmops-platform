variable "project_name" {
  description = "Name prefix for project resources"
  type        = string
  default     = "aws-llmops"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "IPv4 CIDR range for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}
