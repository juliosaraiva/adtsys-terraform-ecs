resource "aws_ecs_cluster" "main" {
  name = "${var.prefix}-cluster"

  tags = var.common_tags
}

resource "aws_cloudwatch_log_group" "ecs_task_logs" {
  name = "${var.prefix}-nginx"

  tags = var.common_tags
}

data "template_file" "api_container_definitions" {
  template = fileexists("${local.module_path}/container-definitions.json.tpl") ? file("${local.module_path}/container-definitions.json.tpl") : file("${local.default_path}/container-definitions.json.tpl")

  vars = {
    app_image        = var.ecr_image_nginx
    log_group_region = var.avail_zone
    log_group_name   = aws_cloudwatch_log_group.ecs_task_logs.name
  }
}

locals {
  module_path  = "modules/ecs/templates"
  default_path = "templates"
}
