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

output "ssh_connection_command" {
  description = "Comando pronto para conectar via SSH"
  value       = "ssh -i ~/.ssh/staging_key ec2-user@${aws_instance.ecs_instance.public_ip}"
}

output "ecs_instance_id" {
  description = "ID da instancia EC2 do cluster ECS"
  value       = aws_instance.ecs_instance.id
}

output "ecs_instance_public_ip" {
  description = "IP publico da EC2 do cluster ECS"
  value       = aws_instance.ecs_instance.public_ip
}

output "ecs_instance_private_ip" {
  description = "IP privado da EC2 do cluster ECS"
  value       = aws_instance.ecs_instance.private_ip
}

output "rds_endpoint" {
  description = "Endpoint de conexao com o banco de dados RDS"
  value       = aws_db_instance.staging_postgres.endpoint
}

output "cloudfront_domain_name" {
  description = "URL publica da CDN para acessar o frontend"
  value       = aws_cloudfront_distribution.frontend_distribution.domain_name
}

output "frontend_s3_bucket_name" {
  description = "Nome do bucket S3 onde faremos o upload dos arquivos do Angular"
  value       = aws_s3_bucket.frontend_bucket.bucket
}