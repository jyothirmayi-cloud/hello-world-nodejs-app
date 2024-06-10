data "aws_ecr_repository" "hello_world" {
  name = "hello-world"
}
resource "aws_ecr_repository" "hello_world" {
  count = length(data.aws_ecr_repository.hello_world.id) == 0 ? 1 : 0
  name  = "hello-world"
}
locals {
  repository_url = length(aws_ecr_repository.hello_world) > 0 ?
    aws_ecr_repository.hello_world[0].repository_url :
    data.aws_ecr_repository.hello_world.repository_url
}



