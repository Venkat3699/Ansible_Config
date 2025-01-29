# Configuring Security Group
resource "aws_security_group" "allow_tls_terraform" {
  name        = "allow_multiple_ports"
  description = "Security group to allow multiple ports"
  vpc_id      = aws_vpc.vpc_terraform.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change this to your IP for production
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "http"
    cidr_blocks = ["0.0.0.0/0"]  # Change this to your IP for production
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change this to your IP for production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "${var.env}_Sg_tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}