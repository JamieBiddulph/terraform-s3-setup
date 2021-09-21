terraform {
    required_providers {
     aws = {
         source = "hashicorp/aws"
         version = "~> 3.27"
     }
    }
    
  required_version = ">= 0.12"
}

  provider "aws" {
      profile = "default"
      region = "eu-west-2"
  }

  module "s3" {
      source = "./aws-s3-cloudfront-iam-setup"
  }
