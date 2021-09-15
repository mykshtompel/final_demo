# Deploy a Web Application in Docker Container on AWS Using Terraform
This page describes how to deploy a web application in Docker container on AWS using Terraform. 

### Tool versions:
- Terraform - 1.02
- AWS CLI - 2.2.23
- Docker - 20.10.8

## Description
This solution was created to demonstrate how deploying a web application in Docker container by creating a cloud infrastructure on AWS based on "Infrastructure as a code" using Terraform looks like. It consists of a web application, Terraform modules, root Terraform module and configuration files to create infrastructure.

The solution creates AWS infrastructure for development and production environments and CI/CD pipeline according to specified requirements to build and deploy a web application in Docker container on ECS Cluster based on Fargate by every commit to particular git branch ("develop" or "main").

The repo contains the next components:
* Web application
* Root Terraform module
* Terraform modules
  * S3 Terraform state - Stores a Terraform state
  * Elastic container registry - Creates an Elastic container registry (ECR) repository to store Docker images
  * Initial build - Builds and pushes initial Docker image to ECR repository
  * ECS cluster - Creates a VPC and a ECS cluster
  * Codebuild - Creates a Codebuild project
* Presentation

## Folders and Files
- /presentation - presentation of the project
- /app - application directory
  - ./web - web application content directory
  - Dockerfile - special file, containing script of instructions, to build Docker image
  - Makefile -  special file, containing shell commands, to build and push Docker image to ECR repository
- /terraform - root Terraform module
  - ./config - configuration directory
    - dev.tfvars - Contains variable values for development environment (git branch "develop")
    - prod.tfvars - Contains variable values for development environment (git branch "main")
    - secret.tfvars - Contains secrets (Github token) for Github repository (not presented in the repo)
    - buildspec.yml - Build SPEC for AWS Codebuild
  - provider.tf - AWS provider configuration
  - terraform.tf - Terraform configuration
  - variables.tf - Terraform variables
  - main.tf - Terraform main file
  - outputs.tf - Terraform outputs
- /modules - Terraform modules
  - s3 - "S3 Terraform state" module directory
  - ecr - "Elastic container registry" module directory
  - init-build - "Initial build" module directory
  - network - "ECS cluster" module directory
  - codebuild - "Codebuild" module directory


## Implemention
### Preparation
- Create an account on AWS 
- Create an user with required permissions using AWS IAM
- Install the required version of Terraform, AWS CLI, and Docker
- Download the repo content
- Obtain Github token
- Create secret.tfvars and add next content "github_oauth_token = YOUR GITHUB TOKEN"
- Change variable values in *.tfvars

### Deployment
#### Initial step
- Add AWS AIM user credentials to ~/.aws/credentials

\[default\]  
aws_access_key_id = YOUR AWS ACCESS KEY ID  
aws_secret_access_key = YOUR AWS SECRET ACCESS KEY  

#### Steps for development environment
- Copy terraform project to your github repo to branch "develop" (backend "s3" for "dev" in ./terraform/terraform.tf file should be uncommented)

- Comment backend "s3" for "dev" and "prod" in ./terraform/terraform.tf file

- Go to ./terraform directory on your local machine and run:

terraform init  
terraform apply -target=module.s3_terraform_state --var-file=./config/dev.tfvars  

- Uncomment backend "s3" for "dev" in ./terraform/terraform.tf file

- Go to ./terraform directory and run (use your ./terraform/config/secret.tfvars):

terraform init  
terraform apply -target=module.elastic_container_registry --var-file=./config/dev.tfvars  
terraform apply -target=module.initial_build --var-file=./config/dev.tfvars  
terraform apply -target=module.ecs_cluster --var-file=./config/dev.tfvars  
terraform apply -target=module.codebuild --var-file=./config/dev.tfvars --var-file=./config/secret.tfvars  

- Check results
  - Go to your AWS account and check created infrastructure resources 
  - Go to the DNS name created Application Load Balancer and check an information on a web page

- Change app/web/index.html file in local git directory and push changes to your github repo to branch "develop"

- Check results
  - Go to your AWS account and check created infrastructure resources 
  - Go to the DNS name created Application Load Balancer and check an information on a web page

#### Steps for production environment
- Copy terraform project to your github repo to branch "prod" (backend "s3" for "prod" in ./terraform/terraform.tf file should be uncommented)

- Delete ./terraform/.terraform, ./terraform/terraform.tfstate, ./terraform/terraform.tfstate.backup, ./terraform/.terraform.lock.hcl files from your local machine

- Comment backend "s3" for "dev" in ./terraform/terraform.tf file

- Go to ./terraform directory and run:

terraform init  
terraform apply -target=module.s3_terraform_state --var-file=./config/prod.tfvars  

- Uncomment backend "s3" for "prod" in ./terraform/terraform.tf file

- Go to ./terraform directory and run (use your ./terraform/config/secret.tfvars file):

terraform init  
terraform apply -target=module.elastic_container_registry --var-file=./config/prod.tfvars  
terraform apply -target=module.initial_build --var-file=./config/prod.tfvars  
terraform apply -target=module.ecs_cluster --var-file=./config/prod.tfvars  
terraform apply -target=module.codebuild --var-file=./config/prod.tfvars --var-file=./config/secret.tfvars  

- Check results
  - Go to your AWS account and check created infrastructure resources 
  - Go to the DNS name created Application Load Balancer and check an information on a web page

- Change app/web/index.html file in local git directory and push changes to your github repo to branch "prod"

- Check results
  - Go to your AWS account and check created infrastructure resources 
  - Go to the DNS name created Application Load Balancer and check an information on a web page

#### Final step
- Delete created infrastructure
