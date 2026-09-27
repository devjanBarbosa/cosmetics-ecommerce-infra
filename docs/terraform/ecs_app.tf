resource "aws_iam_role" "ecs_task_execution_role" {
  name = "staging-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "staging-ecs-task-execution-role"
    Environment = "staging"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/staging-ecommerce-api"
  retention_in_days = 7

  tags = {
    Environment = "staging"
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "staging-ecommerce-api"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = "512"
  memory                   = "768"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "ecommerce-api"
      image     = "janbarbosa/cosmetics-api:v1"
      essential = true
      portMappings = [
        {
          hostPort      = 80
          containerPort = 8080
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "api"
        }
      }
      environment = [
        {
          name  = "SPRING_DATASOURCE_URL"
          value = "jdbc:postgresql://${aws_db_instance.staging_postgres.endpoint}/${var.db_name}"
        },
        {
          name  = "SPRING_DATASOURCE_USERNAME"
          value = var.db_username
        },
        {
          name  = "SPRING_DATASOURCE_PASSWORD"
          value = var.db_password
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app_service" {
  name            = "staging-ecommerce-service"
  cluster         = aws_ecs_cluster.staging_cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "EC2"

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  availability_zone_rebalancing = "DISABLED"

  triggers = {
    redeployment = aws_ecs_task_definition.app.arn
  }

  depends_on = [aws_instance.ecs_instance]
}