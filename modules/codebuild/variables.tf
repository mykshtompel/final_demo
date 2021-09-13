# Module variables
variable "env" {
  type        = string
  default     = "env"
  description = "The name of the environment."
}

variable "app" {
  type        = string
  default     = "app"
  description = "The name of the application."
}

variable "name_container" {
  type        = string
  default     = "container"
  description = "The name of the container."
}

locals {
  codebuild_project_name = "${var.app}-${var.env}-${var.name_container}"
  description            = "Codebuild for ${var.app}-${var.name_container} environment ${var.env}"
  region                 = data.aws_region.current.name
}

variable "github_oauth_token" {
  type        = string
  sensitive   = true
  default     = ""
  description = "The Github OAuth token with repo access permissions."

}

variable "repo_url" {
  type        = string
  default     = ""
  description = "The URL to Github repository to fetch source from."
}

variable "branch_pattern" {
  type        = string
  default     = ""
  description = "The branch pattern of Github repository."
}

variable "git_trigger_event" {
  type        = string
  default     = ""
  description = "The trigger event for Codebuild webhook."
}

variable "build_spec_file" {
  type        = string
  default     = "buildspec.yml"
  description = "The collection of build commands and related settings, in YAML format, that CodeBuild uses to run a build."
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "The VPC ID used by CodeBuild."
}

variable "subnets" {
  type        = list(string)
  default     = null
  description = "The private subnet IDs that include resources used by CodeBuild."
}

variable "security_groups" {
  type        = list(string)
  default     = null
  description = "The security group IDs used by CodeBuild to allow access to resources in the VPC."
}
