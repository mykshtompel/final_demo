# Module output
output "aws_ecr_repository_url" {
  value       = aws_ecr_repository.main.repository_url
  description = "The URL of the repository."
}
