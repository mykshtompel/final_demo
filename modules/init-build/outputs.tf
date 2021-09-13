# Module outputs
output "aws_region_name" {
  value       = data.aws_region.current.name
  description = "The name of the selected AWS region."
}

output "account_id" {
  value       = data.aws_caller_identity.current.account_id
  description = "AWS Account ID number of the account that owns or contains the calling entity."
}

output "confirmation" {
  value = "Done"
}
