# Module "s3_terraform_state" to store Terraform states
module "s3_terraform_state" {
  source      = "../modules/s3"
  bucket_name = var.bucket_name
  table_name  = var.table_name
}

# Module "elastic_container_registry" to store Docker images
module "elastic_container_registry" {
  source         = "../modules/ecr"
  app            = var.app
  env            = var.env
  name_container = var.name_container
}

# Module "initial_build" for create initial Docker image
module "initial_build" {
  source         = "../modules/init-build"
  working_dir    = "${path.root}/../app"
  image_tag      = var.image_tag
  app            = var.app
  env            = var.env
  name_container = var.name_container
}

# Module "ecs_cluster" to create VPC and ECS cluster
module "ecs_cluster" {
  source                    = "../modules/network"
  cidr_block                = var.cidr_block
  aws_dns                   = true
  app_port                  = var.app_port
  taskdef_template          = "${path.root}/../modules/network/web_server.json.tpl"
  web_server_count          = var.web_server_count
  web_server_fargate_cpu    = var.web_server_fargate_cpu
  web_server_fargate_memory = var.web_server_fargate_memory
  aws_ecr_repository_url    = module.elastic_container_registry.aws_ecr_repository_url
  image_tag                 = var.image_tag
  app                       = var.app
  env                       = var.env
  name_container            = var.name_container
}

# Module "codebuild" to create Codebuild project
module "codebuild" {
  source             = "../modules/codebuild"
  vpc_id             = module.ecs_cluster.vpc_id
  subnets            = module.ecs_cluster.private_subnet_ids
  github_oauth_token = var.github_oauth_token
  repo_url           = var.repo_url
  branch_pattern     = var.branch_pattern
  git_trigger_event  = var.git_trigger_event
  build_spec_file    = "terraform/config/buildspec.yml"
  app                = var.app
  env                = var.env
  name_container     = var.name_container
}
