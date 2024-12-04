variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks of public subnets"
  type        = list(string)
}