output "instance_id1" {
  description = "ID of the VPC instance"
  value       = aws_vpc.staging.id
}

output "instance_id2" {
  description = "ID of the subnet instance"
  value       = aws_subnet.subnet_az1.id
}

output "instance_id3" {
  description = "ID of the subnet instance"
  value       = aws_subnet.subnet_az2.id
}


