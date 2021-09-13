# Data sources to get the access to the effective AWS Account ID and AWS region
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
