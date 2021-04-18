output "application_endpoint" {
  value = module.elb.nginx_endpoint
}

output "db_host" {
  value = module.rds.db_host
}