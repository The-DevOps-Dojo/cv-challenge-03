provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
  environment         = var.environment
}

module "security" {
  source              = "./modules/sg"
  vpc_id              = module.vpc.vpc_id
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
}

module "ec2_instance" {
  source = "./modules/ec2" # Path to your module folder

  ubuntu_ami        = var.ubuntu_ami
  instance_type     = var.instance_type
  public_subnet_ids = ["10.0.1.0/24", "10.0.2.0/24"]
  security_group_id = module.security.ansible_sg_id
  key_name          = var.key_name
  environment       = var.environment
}

data "aws_route53_zone" "domain" {
  name = "mytoolings.xyz"
}

resource "aws_route53_record" "main_routes" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "mytoolings.xyz"
  type    = "A"
  ttl     = "300"
  records = [module.ec2_instance.public_ip]
}

resource "aws_route53_record" "db_routes" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "db.mytoolings.xyz"
  type    = "A"
  ttl     = "300"
  records = [module.ec2_instance.public_ip]
}

resource "aws_route53_record" "proxy_routes" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "proxy.mytoolings.xyz"
  type    = "A"
  ttl     = "300"
  records = [module.ec2_instance.public_ip]
}

resource "aws_route53_record" "traefik_routes" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "traefik.mytoolings.xyz"
  type    = "A"
  ttl     = "300"
  records = [module.ec2_instance.public_ip]
}

resource "aws_route53_record" "www_routes" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "www.mytoolings.xyz"
  type    = "A"
  ttl     = "300"
  records = [module.ec2_instance.public_ip]
}

# Generate Ansible inventory
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tmpl",
    {
      master_public_ip = module.ec2_instance.public_ip
      master_hostname  = module.ec2_instance.master_hostname
    }
  )
  filename = "../ansible/inventory.ini"
}

# Run Ansible playbook
resource "null_resource" "ansible_provisioner" {
  depends_on = [
    local_file.ansible_inventory,
    module.ec2_instance,
    module.vpc
  ]

  provisioner "local-exec" {
    command = <<-EOT
      sleep 70 # Reduced wait time since we're using public IPs
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
        -i ../ansible/inventory.ini \
        ../ansible/site.yml
    EOT
  }
}