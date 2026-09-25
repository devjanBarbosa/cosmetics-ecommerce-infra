output "vpc_id" {
  description = "ID of the VPC instance"
  value       = aws_vpc.staging.id
}

output "subnet_id1" {
  description = "ID of the subnet instance"
  value       = aws_subnet.subnet_az1.id
}

output "subnet_id2" {
  description = "ID of the subnet instance"
  value       = aws_subnet.subnet_az2.id
}

output "SecurityGroupApp" {
  description = "ID of the security group instance"
  value       = aws_security_group.staging_app_sg.id
}

output "SecurityGroupBD" {
  description = "ID of the security group instance"
  value       = aws_security_group.staging_bd_sg.id
}


