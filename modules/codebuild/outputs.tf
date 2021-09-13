# Module output
output "codebuild_project_name" {
  value       = aws_codebuild_project.project.name
  description = "The name of the Codebuild project."
}
