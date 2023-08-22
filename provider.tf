provider "aws" {

region  = "ap-south-1"
  assume_role {
    role_arn     = data.aws_iam_role.lambda.arn
    
  }
}
