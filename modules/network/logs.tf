# CloudWatch log group
resource "aws_cloudwatch_log_group" "web_server_log_group" {
  name              = "/ecs/web-server-${var.app}-${var.env}-${var.name_container}"
  retention_in_days = 30

  tags = {
    Name = "web-server-log-group-${var.app}-${var.env}-${var.name_container}"
  }
}

# CloudWatch log stream
resource "aws_cloudwatch_log_stream" "web_server_log_stream" {
  name           = "${var.app}-${var.env}-${var.name_container}-log-stream"
  log_group_name = aws_cloudwatch_log_group.web_server_log_group.name
}
