resource "aws_db_subnet_group" "staging_db_subnet_group" {
  name        = "staging-db-subnet-group"
  description = "Subnets privadas para a instancia RDS PostgreSQL"
  subnet_ids = [
    aws_subnet.staging_private_az1.id,
    aws_subnet.staging_private_az2.id
  ]

  tags = {
    Name        = "staging-db-subnet-group"
    Environment = "staging"
  }
}

resource "aws_db_instance" "staging_postgres" {
  identifier            = "staging-postgres-db"
  allocated_storage     = 20
  max_allocated_storage = 20
  storage_type          = "gp2"
  engine                = "postgres"
  engine_version        = "15"
  instance_class        = "db.t3.micro"

  db_name  = "appdb"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.staging_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.staging_bd_sg.id]
  publicly_accessible    = false

  skip_final_snapshot = true
  multi_az            = false
  deletion_protection = false

  tags = {
    Name        = "staging-postgres-db"
    Environment = "staging"
  }
}