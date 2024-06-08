provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "jyothibucket123"
    key    = "ecs-fargate/terraform.tfstate"
    region = "us-east-1"
  }
}
