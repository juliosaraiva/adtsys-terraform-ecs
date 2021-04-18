variable "prefix" {
  default = "ecs"
  type    = string
}

variable "project" {
  default = "ecs-cluster"
  type    = string
}

variable "contact" {
  default = "email@user.com"
  type    = string
}

variable "bastion_ssh_key_name" {
  default = "ssh_key"
  type    = string
}

variable "ecr_image_nginx" {
  default = "docker.io/nginx:latest"
  type    = string
}