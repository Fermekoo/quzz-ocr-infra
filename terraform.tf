terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.9.0"
    }
  }

  required_version = ">= 1.2"
  
  backend "s3" {
        bucket = "quzz-ocr-s3"
        key = "eks-cluster/terraform.tfstate"
        region = "ap-southeast-1"
        dynamodb_table = "quzz-ocr-infra-state-lock"
        encrypt = true
  }
}