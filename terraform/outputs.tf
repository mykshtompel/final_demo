# Outputs for module "s3_terraform_state"
output "s3_bucket_arn" {
  value       = module.s3_terraform_state.s3_bucket_arn
  description = "The ARN of the bucket."
}

output "s3_bucket_name" {
  value       = module.s3_terraform_state.s3_bucket_name
  description = "The bucket domain name."
}

output "dynamodb_table_name" {
  value       = module.s3_terraform_state.dynamodb_table_name
  description = "The name of the table."
}

# Outputs for module "elastic_container_registry"
output "aws_ecr_repository_url" {
  value       = module.elastic_container_registry.aws_ecr_repository_url
  description = "The URL of the repository."
}

# Outputs for module "initial_build"
output "aws_region_name" {
  value       = module.initial_build.aws_region_name
  description = "The name of the selected AWS region."
}

output "account_id" {
  value       = module.initial_build.account_id
  description = "AWS Account ID number of the account that owns or contains the calling entity."
}

output "confirmation" {
  value = module.initial_build.confirmation
}

# Outputs for module "ecs_cluster"
output "alb_hostname" {
  value       = module.ecs_cluster.alb_hostname
  description = "The DNS name of Application Load Balancer (ALB)."
}

# Outputs for module "codebuild"
output "codebuild_project_name" {
  value       = module.codebuild.codebuild_project_name
  description = "The name of the Codebuild project."
}
