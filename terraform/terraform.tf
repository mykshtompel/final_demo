# Required version of Terraform
terraform {
  required_version = "= 1.0.2"

  # S3 bucket for environment "dev"
  backend "s3" {
    bucket         = "bucket-web1-dev-nginx1-us-east-2"
    key            = "dev/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "table-web1-dev-nginx1-us-east-2"
  }


  # S3 bucket for environment "prod"
  /*
  backend "s3" {
    bucket         = "bucket-web2-prod-nginx2-us-east-2"
    key            = "prod/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "table-web2-prod-nginx2-us-east-2"
  }
*/
  # Required version of AWS provider
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.55"
    }
  }
}
