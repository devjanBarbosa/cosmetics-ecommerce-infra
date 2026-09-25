resource "aws_security_group" "staging_app_sg" {
  name        = "staging_app_sg"
  description = "Security group for staging application"
  vpc_id      = aws_vpc.staging.id

  tags = {
    Name        = "staging_app_sg"
    Environment = "staging"
  }
}

resource "aws_security_group" "staging_bd_sg" {
  name        = "staging_bd_sg"
  description = "Security group for staging database"
  vpc_id      = aws_vpc.staging.id

  tags = {
    Name        = "staging_bd_sg"
    Environment = "staging"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_http_ingress" {
  security_group_id = aws_security_group.staging_app_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "app_ssh_ingress" {
  security_group_id = aws_security_group.staging_bd_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "app_api_ingress" {
  security_group_id = aws_security_group.staging_bd_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 8080
  ip_protocol = "tcp"
  to_port     = 8080
}

resource "aws_vpc_security_group_ingress_rule" "bd_postgresql_ingress" {

  security_group_id            = aws_security_group.staging_bd_sg.id
  referenced_security_group_id = aws_security_group.staging_app_sg.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  description                  = "Permite conexao PostgreSQL apenas vinda da aplicacao"
}

resource "aws_vpc_security_group_egress_rule" "app_all_traffic" {
  security_group_id = aws_security_group.staging_app_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "db_all_traffic" {
  security_group_id = aws_security_group.staging_bd_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
