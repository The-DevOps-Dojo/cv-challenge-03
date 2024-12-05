# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1" # Change this to your preferred region
}

# VPC CIDR
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

# Environment
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

# Ubuntu AMI
variable "ubuntu_ami" {
  description = "The AMI ID for the Ubuntu image"
  type        = string
}

# EC2 Instance Type
variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

# EC2 Key Pair Name
variable "key_name" {
  description = "The name of the key pair to use for EC2 instances"
  type        = string
}

# Domain Name
variable "domain_name" {
  description = "The domain name to use for Route 53"
  type        = string
  default     = "mytoolings.xyz"
}
