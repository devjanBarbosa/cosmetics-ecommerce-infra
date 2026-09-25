data "aws_ami" "ubuntu" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "staging_key" {
  key_name   = "staging_key"
  public_key = file("~/.ssh/staging_key.pub")
}

resource aws_instance "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_az1.id
  key_name      = aws_key_pair.staging_key.key_name
  vpc_security_group_ids = [aws_security_group.staging_app_sg.id]
  associate_public_ip_address = true
  tags = {
    Name        = "staging_app_server"
    Environment = "staging"
  }
}