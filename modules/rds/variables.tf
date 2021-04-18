variable "prefix" {
  default = "ecs"
}

variable "common_tags" {}

variable "vpc_id" {
  description = "VPC ID for the RDS postgres instance"
}

variable "db_name" {
  description = "Database name for the RDS postgres instance"
  default     = "djangoapp"
  type        = string
}

variable "db_username" {
  description = "Username for the RDS postgres instance"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS postgres instance"
  type        = string
}

variable "private_cidr_blocks" {
  description = "List of CIDR for private network"
  type        = list(any)
}