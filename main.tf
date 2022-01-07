resource "aws_instance" "ec2_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  associate_public_ip_address = var.associate_public_ip
  subnet_id = var.subnet_id
  key_name = var.key_pair
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "${var.environment}-bastion"
    Deployment_Method = "terraform"
    Environment = var.environment
  }
}