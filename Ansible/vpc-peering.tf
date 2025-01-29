data "aws_vpc" "ansible_vpc" {
  id = "vpc-081b18ca31f9ebc51" # Controller VPC ID
}

data "aws_route_table" "ansible_vpc_rt" {
  subnet_id = "subnet-094e40b4f4527a013" # Controller Subnet ID
  #If subnet_id giving errors use route table id as below
  # route_table_id = "rtb-0e5fa589e13bc355b"
}

resource "aws_vpc_peering_connection" "ansible-vpc-peering" {
  peer_vpc_id = data.aws_vpc.ansible_vpc.id
  vpc_id      = aws_vpc.Vpc-Terraform.id
  auto_accept = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name   = "${var.env}-Ansible_Vpc_Peering"
    owner  = local.owner
    teamDL = local.teamDL
    env    = "${var.env}"
  }
}

resource "aws_route" "peering-to-ansible-vpc" {
  route_table_id            = aws_route_table.Public-Rt-Terraform.id
  destination_cidr_block    = "192.10.0.0/16" # Controller VPC CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.ansible-vpc-peering.id
  #depends_on                = [aws_route_table.terraform-public]
}

resource "aws_route" "peering-from-ansible-vpc" {
  route_table_id            = data.aws_route_table.ansible_vpc_rt.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.ansible-vpc-peering.id
  depends_on                = [aws_vpc.Vpc-Terraform]
}