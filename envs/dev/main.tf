terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "jhansi-tf-state-0214"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source   = "../../modules/vpc"
  name     = var.name
  vpc_cidr = var.vpc_cidr
  az_count = 3
}