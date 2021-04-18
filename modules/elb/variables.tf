variable "prefix" {
  default = "ecs"
  type    = string
}

variable "public_subnets" {
  default = []
  type    = list
}
variable "vpc_id" {
  type = string
}

variable "common_tags" {}
