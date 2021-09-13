# Required versions of Terraform, AWS provider and NULL provider
terraform {
  required_version = "= 1.0.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.55"
    }
    null = {
      source  = "hashicorp/null"
      version = "= 3.1.0"
    }
  }
}
