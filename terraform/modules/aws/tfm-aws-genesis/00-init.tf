terraform {
  required_version = ">= 0.14.7"
}

provider "aws" {
  alias  = "eu-west-1"
  region = var.provider_eu_west_1
}

provider "aws" {
  alias  = "us-east-1"
  region = var.provider_us_east_1
}
