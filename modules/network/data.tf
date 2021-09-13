# Data sources to get the access to the effective AWS region and AWS Availability Zones 
data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}
