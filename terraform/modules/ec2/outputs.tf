output "public_ip" {
  description = "Public IP of instance"
  value       = aws_instance.instance.public_ip
}

output "master_hostname" {
  description = "Hostname of master node"
  value       = aws_instance.instance.private_dns
}

output "instance_ids" {
  description = "List of worker instance IDs"
  value       = aws_instance.instance[*].id
}