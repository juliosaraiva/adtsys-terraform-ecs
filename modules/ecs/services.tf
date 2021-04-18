resource "aws_ecs_task_definition" "nginx" {
  family                   = "${var.prefix}-nginx"
  container_definitions    = data.template_file.api_container_definitions.rendered
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.app_iam_role.arn
  volume {
    name = var.task_volume_name
  }
  tags = var.common_tags
}

resource "aws_security_group" "ecs_service" {
  description = "Access for the ECS Service"
  name        = "${var.prefix}-ecs-service"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = var.lb_security_group_id
  }

  tags = var.common_tags
}

resource "aws_ecs_service" "nginx" {
  name             = "${var.prefix}-nginx"
  cluster          = aws_ecs_cluster.main.name
  task_definition  = aws_ecs_task_definition.nginx.family
  desired_count    = 1
  launch_type      = var.launch_type
  platform_version = var.platform_version

  network_configuration {
    subnets         = var.private_cidr_blocks
    security_groups = [aws_security_group.ecs_service.id]
  }

  load_balancer {
    target_group_arn = var.lb_target_group_nginx_arn
    container_name   = "nginx"
    container_port   = 80
  }
}