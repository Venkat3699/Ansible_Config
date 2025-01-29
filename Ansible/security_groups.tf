# Configuring Security Group
resource "aws_security_group" "allow_tls_terraform" {
  name        = "allow_multiple_ports"
  description = "Security group to allow multiple ports"
  vpc_id      = aws_vpc.vpc_terraform.id

  # Allowing ingress for allowed ports
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"  # Ensure this is set to "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Change this to your IP for production
    }
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