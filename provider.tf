
terraform {
  required_providers {
    aws = {
      source = "registry.terraform.io/hashicorp/aws"
      version = "5.13.1"
    }
  }
}
provider "aws" {
source = "registry.terraform.io/hashicorp/aws"
      version = "5.13.1"
  region = "ap-south-1"
assume_role {
    role_arn     = data.aws_iam_role.lambda.arn
    
  }
}

  terraform {
  backend "s3" {
    bucket = "3.devops.candidate.exam"
    key    = "Yasin.Sutar"
    region = "ap-south-1"
  }
}

