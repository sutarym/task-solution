data "aws_nat_gateway" "nat" {
  id = "nat-024f2855bf415a0cc"
}

data "aws_vpc" "vpc" {
  id = "vpc-04989d552e9a91336"
}

data "aws_iam_role" "lambda" {
  name = "DevOps-Candidate-Lambda-Role"
}
