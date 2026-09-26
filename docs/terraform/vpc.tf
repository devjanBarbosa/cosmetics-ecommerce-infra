resource "aws_vpc" "staging" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "staging_vpc"
    Environment = "staging"
  }
}

resource "aws_subnet" "subnet_az1" {
  vpc_id            = aws_vpc.staging.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "subnet for us-east-1a"
  }

}

resource "aws_subnet" "subnet_az2" {
  vpc_id            = aws_vpc.staging.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "subnet for us-east-1b"
  }
}

resource "aws_internet_gateway" "staging" {
  vpc_id = aws_vpc.staging.id
  tags = {
    Name = "Internet Gateway for staging"
  }
}

resource "aws_route_table" "staging" {
  vpc_id = aws_vpc.staging.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.staging.id
  }

  tags = {
    Name = "Route table for staging"
  }
}

resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.subnet_az1.id
  route_table_id = aws_route_table.staging.id
}

resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.subnet_az2.id
  route_table_id = aws_route_table.staging.id
}

# Subnets Privadas
resource "aws_subnet" "staging_private_az1" {
  vpc_id            = aws_vpc.staging.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.3.0/24"

  tags = {
    Name = "staging-private-subnet-az1"
  }
}

resource "aws_subnet" "staging_private_az2" {
  vpc_id            = aws_vpc.staging.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.4.0/24"

  tags = {
    Name = "staging-private-subnet-az2"
  }
}

resource "aws_route_table" "staging_private_rt" {
  vpc_id = aws_vpc.staging.id

  tags = {
    Name = "staging-private-route-table"
  }
}

resource "aws_route_table_association" "private_az1" {
  subnet_id      = aws_subnet.staging_private_az1.id
  route_table_id = aws_route_table.staging_private_rt.id
}

resource "aws_route_table_association" "private_az2" {
  subnet_id      = aws_subnet.staging_private_az2.id
  route_table_id = aws_route_table.staging_private_rt.id
}