# ADTSys Challenge - ECS Cluster
This Terraform module deploys an Nginx Page on AWS ECS Fargate service as a challenge proposed by [ADTSys](https://www.adtsys.com.br/).

[![Actions Status: Format](https://github.com/juliosaraiva/adt-terraform-ecs/workflows/Terraform/badge.svg)](https://github.com/juliosaraiva/adt-terraform-ecs/actions?query=workflow%3A"Terraform")


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.54.0 |

## Architecture
Bellow is the architecture proposed with RDS Postgres Database.

![Architecture](images/Architecture-V3.png)

## AWS Services used by this project

## Usage
---
Inside of policies directory, I added the policies that should be used for the users to manage the infrastructure on AWS. Pay attention for some parts that should be changed to specify your S3 bucket and DynamoDB.

1. create a s3 bucket and dynamoDB table with a primary key `LockID`. It will ensure locking to prevent concurrent runs against the same state. Then update the values into terraform backend.

[Examples](https://www.terraform.io/docs/language/settings/backends/s3.html#example-configuration)

```
terraform {
  backend "s3" {
    bucket         = "adt-tfstate"
    key            = "state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "adt-tfstate-lock"
    encrypt        = true
  }
}
```

2. Rename from `sample.tfvars` to `terraform.tfvars` and update the variables as needed.

The following steps use docker-compose to ensure the commands are executed using terraform `0.13.6`. Feel free to run terraform without docker-compose.

3. `docker-compose run --rm terraform init`

4. `docker-compose run --rm terraform validate`

5. `docker-compose run --rm terraform plan`

6. `docker-compose run --rm terraform apply`

## Inputs
|Name|Description|Type|Default|Required|
|----|-----------|----|-------|--------|
|prefix|Create a prefix to set in some resources|string|ecs|no|
|project|Name of the project is a description|string|ecs-cluster|no|
|contact|Maintainer of the project|string|email@domain.com|no|
|bastion_ssh_key_name|Name of ssh key defined in key pairs to use by bastion server|string|ssh_key|no|
|ecr_image_nginx|Image that will be used by ECS Service|string|docker.io/nginx:latest|no|

## Outputs
|Name|Description|
|----|-----------|
|application_endpoint|Show the URL to access nginx|
