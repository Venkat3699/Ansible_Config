# Configuring Security Group
resource "aws_security_group" "allow_tls_terraform" {
  name        = "allow_multiple_ports"
  description = "Security group to allow multiple ports"
  vpc_id      = aws_vpc.vpc_terraform.id

  # Allowing ingress for allowed ports
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.1.1.0/32"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["10.1.1.0/32"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.2.1.0/32"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "${var.env}_Sg_tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = var.env
  }
}