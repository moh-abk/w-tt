terraform {
  required_version = ">= 0.14.7"

  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
  }
}

provider "aws" {
  alias  = "aws_us_east_1"
  region = var.acm_cert_region
}

provider "aws" {
  region = var.aws_region
}
