# Module outputs
output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the bucket."
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket_domain_name
  description = "The bucket domain name."
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.id
  description = "The name of the table."
}
