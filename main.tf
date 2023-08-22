# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

# Configure the AWS Provider
# provider "aws" {
#   region = "ap-south-1"
# }



#public Subnet
resource "aws_subnet" "PublicSubnet" {
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "PublicSubnet"
  }
}

#Private Subnet
resource "aws_subnet" "PrivateSubnet" {
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "PrivateSubnet"
  }
}

# public route table 
resource "aws_route_table" "PublicRT" {
  vpc_id = data.aws_vpc.vpc.id

  }

# Private route table 
resource "aws_route_table" "PrivateRT" {
  vpc_id = data.aws_vpc.vpc.id

  }

# Rt association Public to Public 
resource "aws_route_table_association" "PublicToPublic" {
  subnet_id      = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.PublicRT.id
}

# Rt association Private to Private 
resource "aws_route_table_association" "PrivateToPrivate" {
  subnet_id      = aws_subnet.PrivateSubnet.id
  route_table_id = aws_route_table.PrivateRT.id
}


resource "aws_route" "RouteInPublicRT_TO_IGW" {
  route_table_id            = aws_route_table.PublicRT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.gw.id
  depends_on                = [aws_route_table.PublicRT]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = "gw"
  }
}

resource "aws_route" "RouteInPrivateRT_TO_NATGW" {
  route_table_id            = aws_route_table.PrivateRT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = data.aws_nat_gateway.nat.id
  depends_on                = [aws_route_table.PrivateRT]
}


resource "aws_lambda_function" "lambda_handler" {
  filename      = "lambda_handler.zip"
  function_name = "lambda_handler"
  role          = data.aws_iam_role.lambda.arn
  handler       = "lambda_handler"
  runtime       = "pythom3.6"

  
}



