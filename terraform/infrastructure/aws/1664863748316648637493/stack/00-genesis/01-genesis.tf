module "genesis" {
  source = "../../../../../modules/aws/tfm-aws-genesis"

  provider_eu_west_1 = "eu-west-1"
  provider_us_east_1 = "us-east-1"
}
