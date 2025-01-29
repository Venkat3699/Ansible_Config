data "aws_vpc" "ansible_vpc" {
  id = "vpc-006b27055cd77ba00" # Controller VPC ID
}

data "aws_route_table" "ansible_vpc_rt" {
  subnet_id = "subnet-0783719d4ed315853" # Controller Subnet ID
}

resource "aws_vpc_peering_connection" "ansible_vpc_peering" {
  peer_vpc_id = data.aws_vpc.ansible_vpc.id
  vpc_id      = aws_vpc.vpc_terraform.id
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

resource "aws_route" "peering_to_ansible_vpc" {
  route_table_id            = aws_route_table.public_rt_terraform.id
  destination_cidr_block    = "10.0.0.0/16" # Controller VPC CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.ansible_vpc_peering.id
}

resource "aws_route" "peering_from_ansible_vpc" {
  route_table_id            = data.aws_route_table.ansible_vpc_rt.id
  destination_cidr_block    = "172.31.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.ansible_vpc_peering.id
}