variable "prefix" {
  default = "ro"
  type    = string
}

variable "bastion_ssh_key_name" {
  description = "Key Pair Name"
  default     = ""
  type        = string
}

variable "subnet_id" {
  description = "Public Subnet Id"
  type        = string
}

variable "common_tags" {
  description = "Common Tags"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "private_cidr_blocks" {
  description = "List of private cidr_blocks"
  type        = list(any)
}