# Output the public IP from the module
output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = module.ec2_instance.public_ip
}

output "ec2_instance_id" {
  description = "The ID of the EC2 instance."
  value       = module.ec2_instance.instance_ids
}

output "ansible_dns" {
  description = "DNS for server"
  value       = aws_route53_record.main_routes.fqdn
}

output "db_dns" {
  description = "DNS for server"
  value       = aws_route53_record.db_routes.fqdn
}

output "proxy_dns" {
  description = "DNS for server"
  value       = aws_route53_record.proxy_routes.fqdn
}