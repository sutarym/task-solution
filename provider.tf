
provider "aws" {   
  region = "ap-south-1"
access_key = "AKIARN47KMZ7CBDA7FOU"
  secret_key = "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"

    
  }


  terraform {
  backend "s3" {
    bucket = "1.devops.candidate.exam"
    key    = "Yasin.Sutar"
    region = "ap-south-1"
  }
}

