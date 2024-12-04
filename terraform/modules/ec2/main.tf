# resource "tls_private_key" "web_server_key" {
#   algorithm = "RSA"
#   rsa_bits  = 2048
# }

# resource "aws_key_pair" "web_server_key" {
#   key_name   = "my-ezekiel-key"
#   public_key = tls_private_key.web_server_key.public_key_openssh
# }

resource "aws_instance" "instance" {
  ami           = var.ubuntu_ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_ids[0] 
  associate_public_ip_address = true       

  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name        = "${var.environment}-ansible-master"
    Environment = var.environment
  }
}