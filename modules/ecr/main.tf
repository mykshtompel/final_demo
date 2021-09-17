# ECR repository
resource "aws_ecr_repository" "main" {
  name                 = "${var.app}-${var.env}-${var.name_container}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

# ECR repository policy
resource "aws_ecr_repository_policy" "main" {
  repository = aws_ecr_repository.main.name
  policy     = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Access to the ECR repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
}
EOF
}
