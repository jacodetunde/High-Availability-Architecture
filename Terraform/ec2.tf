resource "aws_instance" "Bastion" {
  ami                         = var.ami
  instance_type               = var.instance_type
  availability_zone           = var.availability_zones[0]
  key_name                    = var.keypair
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public1.id
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  tags  =  {
    Name = "${var.name}-Bastion-Host"
  }                    

    # iam_instance_profile = var.iam_role
}
