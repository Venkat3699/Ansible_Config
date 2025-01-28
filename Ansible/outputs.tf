output "vpc_id" {
  value = aws_vpc.Vpc-Terraform.id
}

output "vpc_arn" {
  value = aws_vpc.Vpc-Terraform.arn
}

output "sg_id" {
  value = aws_security_group.allow_tls-Terraform.id
}