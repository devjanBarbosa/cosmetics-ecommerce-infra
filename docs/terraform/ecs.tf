resource "aws_ecs_cluster" "staging_cluster" {
  name = "staging-cluster"
  tags = {
    Name        = "staging-cluster"
    Environment = "staging"
  }
}

data "aws_ssm_parameter" "ecs_optimized_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
}

resource "aws_instance" "ecs_instance" {
  ami           = data.aws_ssm_parameter.ecs_optimized_ami.value
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet_az1.id
  key_name      = aws_key_pair.staging_key.key_name

  iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.name

  vpc_security_group_ids      = [aws_security_group.staging_app_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              echo "ECS_CLUSTER=${aws_ecs_cluster.staging_cluster.name}" >> /etc/ecs/ecs.config
              EOF

  tags = {
    Name        = "staging-ecs-instance"
    Environment = "staging"
  }
}