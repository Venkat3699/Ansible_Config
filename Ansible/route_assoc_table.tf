# Configuring Route Table Association for Public and Private
resource "aws_route_table_association" "rta_public_terraform" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt_terraform.id
}

resource "aws_route_table_association" "rta_private_terraform" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt_terraform.id
}