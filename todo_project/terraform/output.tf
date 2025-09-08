output "ec2_public_ip" {
  value = aws_instance.project.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.project.public_dns
}
output "ec2_instance_id" {
  value = aws_instance.project.id
}

output "security_group_id" {
  value = aws_security_group.demo_project.id
}

output "vpc_id" {
  value = data.aws_vpc.default.id
}