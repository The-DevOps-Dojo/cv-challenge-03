# Define the AMI ID for the Ubuntu image
variable "ubuntu_ami" {
  description = "The AMI ID for the Ubuntu instance."
  type        = string
}

# Define the instance type
variable "instance_type" {
  description = "The type of EC2 instance to create (e.g., t2.micro, t3.medium)."
  type        = string
}

# Define the public subnet IDs
variable "public_subnet_ids" {
  description = "A list of public subnet IDs where the instance can be launched."
  type        = list(string)
}

# Define the security group ID
variable "security_group_id" {
  description = "The security group ID to assign to the EC2 instance."
  type        = string
}

# Define the key pair name for SSH access
variable "key_name" {
  description = "The name of the key pair for SSH access to the instance."
  type        = string
}

# Define the environment name
variable "environment" {
  description = "The environment name (e.g., dev, staging, production) used for tagging."
  type        = string
}
