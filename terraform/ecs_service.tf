resource "aws_ecs_task_definition" "hello_world" {
  family                = "hello-world"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn    = aws_iam_role.ecs_task_execution.arn
  cpu                   = "256"
  memory                = "512"
  container_definitions = jsonencode([
    {
      name      = "hello-world"
      image     = "${aws_ecr_repository.hello_world[0].repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}
