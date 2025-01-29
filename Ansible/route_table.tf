# Configuring Route Table for Public Subnet
resource "aws_route_table" "public_rt_terraform" {
  vpc_id = aws_vpc.vpc_terraform.id

  tags = {
    Name   = "${var.env}_Public_RT"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}

resource "aws_route" "igw_route" {
  route_table_id         = aws_route_table.public_rt_terraform.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_terraform.id
}

# Configuring Route Table for Private Subnet
resource "aws_route_table" "private_rt_terraform" {
  vpc_id = aws_vpc.vpc_terraform.id

  tags = {
    Name   = "${var.env}_Private_RT"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}

