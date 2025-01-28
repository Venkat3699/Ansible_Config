# Configuring Route Table for Public Subnet
resource "aws_route_table" "Public-Rt-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.Igw-Terraform.id
  # }

  tags = {
    Name   = "${var.env}_Public-RT"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}

#VPC Peering Routes are getting recreated when we apply. To overcome this issue Routing Table
#is created with out any routes & routes for igw,peering are created seperatly.
#https://stackoverflow.com/questions/49174421/terraform-route-table-forcing-new-resource-every-apply

resource "aws_route" "igw-route" {
  route_table_id         = aws_route_table.Public-Rt-Terraform.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.Igw-Terraform.id
}

# Configuring Route Table for Private Subnet
resource "aws_route_table" "Private-Rt-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  tags = {
    Name   = "${var.env}_Private-RT"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}
