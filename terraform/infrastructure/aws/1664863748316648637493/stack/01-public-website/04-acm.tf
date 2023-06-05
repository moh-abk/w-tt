module "public_website_s3_acm" {
  providers = {
    aws = aws.aws_us_east_1
  }

  source = "../../../../../modules/aws/tfm-aws-acm"

  domain_name = var.public_website_domain_name
  zone_id     = var.zone_id

  wait_for_validation = true

  subject_alternative_names = [
    "*.${var.public_website_domain_name}"
  ]

  tag_budget_owner     = var.tag_budget_owner
  tag_cost_center      = var.tag_cost_center
  tag_environment      = var.tag_environment
  tag_operations_owner = var.tag_operations_owner
  tag_project_name     = var.tag_project_name
  tag_system_owner     = var.tag_system_owner
}
