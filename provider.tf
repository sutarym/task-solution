
provider "aws" {   
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

