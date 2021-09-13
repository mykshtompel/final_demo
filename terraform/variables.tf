# General variables
variable "aws_profile" {
  type        = string
  default     = "default"
  description = "The name of AWS profile."
}

variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "The name of AWS region."
}

# Variables for module "s3_terraform_state"
variable "bucket_name" {
  type        = string
  default     = "bucket-app-env-container-us-east-2"
  description = "The name of the bucket."
}

variable "table_name" {
  type        = string
  default     = "table-app-env-container-us-east-2"
  description = "The name of the table."
}

# General variables for other modules
variable "app" {
  type        = string
  default     = "app"
  description = "The name of the application."
}

variable "env" {
  type        = string
  default     = "env"
  description = "The name of the environment."
}

variable "name_container" {
  type        = string
  default     = "container"
  description = "The name of the container."
}

# Variables for module "initial_build"
variable "working_dir" {
  type        = string
  default     = ""
  description = "The path to the working directory (Makefile location)."
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "The tag of the initial Docker image."
}

# Variables for module "ecs_cluster"
variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The CIDR block for the VPC."
}

variable "app_port" {
  type        = number
  default     = 80
  description = "The port on which the load balancer is listening."
}

variable "taskdef_template" {
  type        = string
  default     = "web_server.json.tpl"
  description = "The JSON document that provides container definitions."
}

variable "web_server_count" {
  type        = number
  default     = 1
  description = "The number of instances of the task definition to place and keep running."
}

variable "web_server_fargate_cpu" {
  type        = number
  description = "The number of cpu units used by the task. (1 vCPU = 1024 CPU units)"
  default     = 256
}

variable "web_server_fargate_memory" {
  type        = number
  description = "The amount of memory used by the task. (in MiB)"
  default     = 512
}

# Variables for module "codebuild"
variable "github_oauth_token" {
  type        = string
  sensitive   = true
  default     = ""
  description = "The Github OAuth token with repo access permissions."
}

variable "repo_url" {
  type        = string
  default     = "https://github.com/mykshtompel/demo"
  description = "The URL to Github repository to fetch source from."
}

variable "branch_pattern" {
  type        = string
  default     = "^refs/heads/dev$"
  description = "The branch pattern of Github repository."
}

variable "git_trigger_event" {
  type        = string
  default     = "PUSH"
  description = "The trigger event for Codebuild webhook."
}
