resource "aws_ecr_repository" "hello_world" {
  name = "hello-world"
  
  lifecycle {
    ignore_changes = [name]
  }
}

