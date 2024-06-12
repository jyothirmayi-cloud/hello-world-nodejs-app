resource "aws_ecs_task_definition" "hello_world" {
  family               = "hello-world"
  network_mode         = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn   = aws_iam_role.ecs_task_execution.arn
  cpu                  = "256"
  memory               = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "hello-world"
      image     = "${local.repository_url}:latest"
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

resource "aws_ecs_service" "hello_world" {
  name            = "hello-world"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.hello_world.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets = aws_subnet.public.*.id
    security_groups = [aws_security_group.allow_http.id]
    assign_public_ip = true
  }
}

