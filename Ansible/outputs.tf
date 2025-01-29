output "vpc_id" {
  value = aws_vpc.vpc_terraform.id
}

output "vpc_arn" {
  value = aws_vpc.vpc_terraform.arn
}

output "sg_id" {
  value = aws_security_group.allow_tls_terraform.id
}