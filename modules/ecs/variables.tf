variable "prefix" {
  default = ""
  type    = string
}

variable "common_tags" {}

variable "ecr_image_nginx" {
  type = string
}

variable "avail_zone" {
  type = string
}

variable "requires_compatibilities" {
  default = ["FARGATE"]
  type    = list
}

variable "network_mode" {
  default = "awsvpc"
  type    = string
}

variable "task_cpu" {
  default = 256
  type    = number
}

variable "task_memory" {
  default = 512
  type    = number
}

variable "task_volume_name" {
  default = "webserver"
  type    = string
}

variable "vpc_id" {
  type = string
}

variable "launch_type" {
  default = "FARGATE"
  type    = string
}

variable "platform_version" {
  default = "1.4.0"
  type    = string
}

variable "private_cidr_blocks" {
  type = list
}

variable "assign_public_ip" {
  default = true
  type    = bool
}

variable "lb_security_group_id" {}

variable "lb_target_group_nginx_arn" {
}