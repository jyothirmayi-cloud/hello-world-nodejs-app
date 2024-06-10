data "aws_ecr_repository" "hello_world" {
  name = "hello-world"
}
resource "aws_ecr_repository" "hello_world" {
  count = length(data.aws_ecr_repository.hello_world.id) == 0 ? 1 : 0
  name  = "hello-world"
}




