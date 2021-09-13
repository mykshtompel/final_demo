# General variables
aws_profile = "default"
aws_region  = "us-east-2"

# Variables for module "s3_terraform_state"
bucket_name = "bucket-web2-prod-nginx2-us-east-2"
table_name  = "table-web2-prod-nginx2-us-east-2"

# General variables for other modules
env            = "prod"
app            = "web2"
name_container = "nginx2"

# Variables for module "initial_build"
image_tag = "0.0.1"

# Variables for module "ecs_cluster"
cidr_block                = "10.20.0.0/16"
app_port                  = 80
web_server_fargate_cpu    = 256
web_server_fargate_memory = 512
web_server_count          = 2

# Variables for module "codebuild"
repo_url          = "https://github.com/mykshtompel/final_demo"
branch_pattern    = "^refs/heads/main$"
git_trigger_event = "PUSH"
