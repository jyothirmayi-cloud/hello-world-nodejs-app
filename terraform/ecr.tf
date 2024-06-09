# Data source to check if the ECR repository already exists
data "aws_ecr_repository" "hello_world" {
  name = "hello-world"
  # This will return the repository if it exists
}

resource "aws_ecr_repository" "hello_world" {
  count = length(data.aws_ecr_repository.hello_world.repository_url) == 0 ? 1 : 0
  name  = "hello-world"
}


