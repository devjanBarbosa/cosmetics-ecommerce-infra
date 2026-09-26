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


output "app_server_id" {
  description = "ID da instancia EC2"
  value       = aws_instance.app_server.id
}

output "app_server_public_ip" {
  description = "IP publico da instancia EC2 (use para conexao SSH e web)"
  value       = aws_instance.app_server.public_ip
}

output "app_server_private_ip" {
  description = "IP privado da instancia na VPC"
  value       = aws_instance.app_server.private_ip
}

output "ssh_connection_command" {
  description = "Comando pronto para conectar via SSH"
  value       = "ssh -i ~/.ssh/staging_key ubuntu@${aws_instance.app_server.public_ip}"
}

output "rds_endpoint" {
  description = "Endpoint de conexao com o banco de dados RDS"
  value       = aws_db_instance.staging_postgres.endpoint
}
