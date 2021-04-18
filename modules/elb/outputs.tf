output "nginx_endpoint" {
  value = aws_lb.nginx.dns_name
}

output "lb_security_group_id" {
  value = aws_security_group.lb.id
}

output "lb_target_group_nginx_arn" {
  value = aws_lb_target_group.nginx.arn
}