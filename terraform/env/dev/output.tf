output "vpc_id" {
  description = "ID of the project VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the project public subnet"
  value       = module.vpc.public_subnet_id
}

output "s3_bucket_name" {
  description = "Name of the project S3 bucket"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN of the project S3 bucket"
  value       = module.s3.bucket_arn
}

output "iam_role_name" {
  description = "Name of the application IAM role"
  value       = module.iam.app_role_name
}

output "iam_role_arn" {
  description = "ARN of the application IAM role"
  value       = module.iam.app_role_arn
}

output "app_instance_profile_name" {
  description = "Name of the application EC2 instance profile"
  value       = module.iam.app_instance_profile_name
}

