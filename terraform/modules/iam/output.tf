output "app_role_name" {
  description = "Name of the application IAM role"
  value       = aws_iam_role.app.name
}

output "app_role_arn" {
  description = "ARN of the application IAM role"
  value       = aws_iam_role.app.arn
}

output "app_instance_profile_name" {
  description = "Name of the application EC2 instance profile"
  value = aws_iam_instance_profile.app.name
}
