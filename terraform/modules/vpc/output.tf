output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.ansible_vpc.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public_subnets[*].id
}