terraform {
  backend "s3" {
    bucket         = "remessa-online-tfstate"
    key            = "state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "remessa-online-tfstate-lock"
    encrypt        = true
  }
}

provider "aws" {
  profile = "terraform"
  region  = "us-east-1"
  version = "~> 2.54.0"
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    Owner       = var.contact
    ManagedBy   = "Terraform"
  }
}

data "aws_region" "current" {}

module "networking" {
  source      = "./modules/networking"
  avail_zone  = data.aws_region.current.name
  prefix      = var.prefix
  common_tags = local.common_tags
}

locals {
  private_cidr_blocks = [
    module.networking.subnet_id_private_a,
    module.networking.subnet_id_private_b
  ]
  public_cidr_blocks = [
    module.networking.subnet_id_public_a,
    module.networking.subnet_id_public_b
  ]
}

module "bastion" {
  source               = "./modules/bastion"
  prefix               = var.prefix
  common_tags          = local.common_tags
  bastion_ssh_key_name = var.bastion_ssh_key_name
  subnet_id            = module.networking.subnet_id_public_a
  vpc_id               = module.networking.vpc_id
  private_cidr_blocks  = local.private_cidr_blocks
}

module "ecs" {
  source                    = "./modules/ecs"
  prefix                    = var.prefix
  avail_zone                = data.aws_region.current.name
  common_tags               = local.common_tags
  ecr_image_nginx           = var.ecr_image_nginx
  vpc_id                    = module.networking.vpc_id
  private_cidr_blocks       = local.private_cidr_blocks
  lb_security_group_id      = [module.elb.lb_security_group_id]
  lb_target_group_nginx_arn = module.elb.lb_target_group_nginx_arn
}

module "elb" {
  source         = "./modules/elb"
  prefix         = var.prefix
  public_subnets = local.public_cidr_blocks
  vpc_id         = module.networking.vpc_id
  common_tags    = local.common_tags
}