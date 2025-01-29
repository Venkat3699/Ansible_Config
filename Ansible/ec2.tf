data "aws_ami" "my_ami" {
  most_recent = true
  name_regex  = "^Ansible"
  owners      = ["682033479178"]
}

# Creating EC2 Instances
resource "aws_instance" "webservers" {
  count                       = var.env == "dev" ? 3 : 1
  ami                         = data.aws_ami.my_ami.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_tls_terraform.id]
  subnet_id                   = aws_subnet.public_subnets[count.index].id

  tags = {
    Name   = "${var.env}-PublicServer-${count.index + 1}"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}