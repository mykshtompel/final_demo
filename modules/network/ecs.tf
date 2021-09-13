# ECS Cluster
resource "aws_ecs_cluster" "web_server" {
  name = "${var.app}-${var.env}-${var.name_container}-cluster"

  tags = {
    Name = "${var.app}-${var.env}-${var.name_container}-cluster"
  }
}

# ECS container definition
data "template_file" "web_server" {
  template = file(var.taskdef_template)

  vars = {
    image                     = local.image
    app_port                  = var.app_port
    web_server_fargate_cpu    = var.web_server_fargate_cpu
    web_server_fargate_memory = var.web_server_fargate_memory
    aws_region                = data.aws_region.current.name
    env                       = var.env
    app                       = var.app
    name_container            = var.name_container
    image_tag                 = var.image_tag
  }
}

# ECS task definition
resource "aws_ecs_task_definition" "web_server" {
  family                   = "${var.app}-${var.env}-${var.name_container}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.web_server_fargate_cpu
  memory                   = var.web_server_fargate_memory
  container_definitions    = data.template_file.web_server.rendered
}

# ECS service
resource "aws_ecs_service" "web_server" {
  name            = "${var.app}-${var.env}-${var.name_container}-service"
  cluster         = aws_ecs_cluster.web_server.id
  task_definition = aws_ecs_task_definition.web_server.arn
  desired_count   = var.web_server_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.web_server_task.id]
    subnets         = aws_subnet.private_subnet.*.id
    #assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.web_server.id
    container_name   = "${var.app}-${var.env}-${var.name_container}-web-server"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.http, aws_iam_role_policy.ecs_task_execution_role]
}

# ECS task security group
resource "aws_security_group" "web_server_task" {
  name   = "${var.app}-${var.env}-${var.name_container}-web-server-task-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app}_${var.env}_${var.name_container}_web_server_task_sg"
  }
}
