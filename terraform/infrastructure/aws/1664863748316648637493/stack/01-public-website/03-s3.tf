module "public_website_s3" {
  source = "../../../../../modules/aws/tfm-aws-s3-bucket"

  bucket = var.public_website_s3_bucket_name

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  tag_project_name     = var.tag_project_name
  tag_environment      = var.tag_environment
  tag_cost_center      = var.tag_cost_center
  tag_operations_owner = var.tag_operations_owner
  tag_system_owner     = var.tag_system_owner
  tag_budget_owner     = var.tag_budget_owner
  tag_service          = "public-website"
}

resource "aws_s3_bucket_policy" "public_website_s3_bucket_policy" {
  bucket = lookup(module.public_website_s3.s3_result, "s3_bucket_id")
  policy = data.aws_iam_policy_document.public_website_s3_bucket_iam_policy_document.json
}

data "aws_iam_policy_document" "public_website_s3_bucket_iam_policy_document" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      lookup(module.public_website_s3.s3_result, "s3_bucket_arn"),
      "${lookup(module.public_website_s3.s3_result, "s3_bucket_arn")}/*",
    ]
  }
}

resource "aws_s3_object" "public_website_s3_object" {
  bucket = lookup(module.public_website_s3.s3_result, "s3_bucket_id")
  acl    = "private"
  key    = "/"
  source = "../../../../../../../tech-test"
}
