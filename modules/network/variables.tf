# Module variables

# General variables
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

# Variables for Network
variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The CIDR block for the VPC."
}

variable "aws_dns" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable DNS support and DNS hostnames in the VPC."
}

locals {
  # Number of public subnets
  number_public_subnets = 2
  # Number of private subnets
  number_private_subnets = 2
  # A list of the Availability Zone names available to the account
  azs = data.aws_availability_zones.available.names
}

# Variables for Application Load Balancer
variable "app_port" {
  type        = number
  default     = 80
  description = "The port on which the load balancer is listening."
}

variable "app_target_port" {
  type        = number
  default     = 80
  description = "The port on which targets receive traffic, unless overridden when registering a specific target."
}

variable "health_check_path" {
  type        = string
  default     = "/"
  description = "The destination for the health check request. Required for HTTP/HTTPS ALB."
}

# Variables for ECS
variable "name_container" {
  type        = string
  default     = "container"
  description = "The name of the container."
}

variable "ecs_task_execution_role_name" {
  type        = string
  default     = "TaskExecutionRole"
  description = "The name of IAM role that the Amazon ECS container agent and the Docker daemon can assume."
}

variable "ecs_task_role_name" {
  type        = string
  default     = "TaskRole"
  description = "The name of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
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
  default     = 256
  description = "The number of cpu units used by the task. (1 vCPU = 1024 CPU units)"
}

variable "web_server_fargate_memory" {
  type        = number
  default     = 512
  description = "The amount of memory used by the task. (in MiB)"
}

variable "aws_ecr_repository_url" {
  type        = string
  description = "The URL of the repository."
}

variable "image_tag" {
  type        = string
  description = "The tag of the Docker image."
}

locals {
  # The name of the Docker image
  image = format("%s:%s", var.aws_ecr_repository_url, var.image_tag)
}
