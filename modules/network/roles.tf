#ECS task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.app}-${var.env}-${var.name_container}-${var.ecs_task_execution_role_name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

#ECS task execution role data
data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

#ECS task execution role policy
resource "aws_iam_role_policy" "ecs_task_execution_role" {
  name_prefix = "ecs_iam_role_policy"
  role        = aws_iam_role.ecs_task_execution_role.id
  policy      = data.template_file.ecs_service_policy.rendered
}

#ECS service policy data
data "template_file" "ecs_service_policy" {
  template = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:DeregisterContainerInstance",
        "ecs:DiscoverPollEndpoint",
        "ecs:Poll",
        "ecs:RegisterContainerInstance",
        "ecs:StartTelemetrySession",
        "ecs:Submit*",
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe",
        "ec2:DescribeInstances"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

#ECS task role
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.app}-${var.env}-${var.name_container}-${var.ecs_task_role_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

#ECS task role policy
resource "aws_iam_role_policy" "ecs_task_role" {
  name   = "${var.app}-${var.env}-${var.name_container}-${var.ecs_task_role_name}"
  role   = aws_iam_role.ecs_task_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
