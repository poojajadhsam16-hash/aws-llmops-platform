output "vpc_id" {
  description = "ID of the VPC created for the dev environment"
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value = module.vpc.public_subnet_id
}
