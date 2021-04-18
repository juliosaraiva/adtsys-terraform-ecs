variable "prefix" {
  default = "ro"
  type    = string
}

variable "common_tags" {
  default = ""
}

variable "avail_zone" {
  default = "us-east-1"
  type    = string
}

variable "vpc_cidr_block" {
  description = "CIDR Block for VPC"
  default     = "10.0.0.0/16"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable support DNS for VPC"
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for VPC"
  default     = true
}

variable "cidr_block_public_a" {
  default = "10.0.1.0/24"
  type    = string
}

variable "cidr_block_public_b" {
  default = "10.0.2.0/24"
  type    = string
}

variable "cidr_block_private_a" {
  default = "10.0.10.0/24"
  type    = string
}

variable "cidr_block_private_b" {
  default = "10.0.20.0/24"
  type    = string
}
