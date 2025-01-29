# Configuring VPC
resource "aws_vpc" "vpc_terraform" {
  cidr_block         = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name   = "${var.env}_VPC_tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}

# Configuring Internet Gateway
resource "aws_internet_gateway" "igw_terraform" {
  vpc_id = aws_vpc.vpc_terraform.id

  tags = {
    Name   = "${var.env}_IGW_tf"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}