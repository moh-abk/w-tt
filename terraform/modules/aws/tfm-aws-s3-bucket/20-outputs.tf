#--------------------------------------------------------------
# Outputs
#--------------------------------------------------------------

locals {
  s3_outputs = {
    inputs = {
      s3_bucket_id                          = try(aws_s3_bucket_policy.s3_bucket_policy[0].id, aws_s3_bucket.s3_bucket.id, "")
      s3_bucket_arn                         = try(aws_s3_bucket.s3_bucket.arn, "")
      s3_bucket_bucket_domain_name          = try(aws_s3_bucket.s3_bucket.bucket_domain_name, "")
      s3_bucket_bucket_regional_domain_name = try(aws_s3_bucket.s3_bucket.bucket_regional_domain_name, "")
      s3_bucket_hosted_zone_id              = try(aws_s3_bucket.s3_bucket.hosted_zone_id, "")
      s3_bucket_region                      = try(aws_s3_bucket.s3_bucket.region, "")
      s3_bucket_website_endpoint            = try(aws_s3_bucket_website_configuration.s3_bucket_website_configuration[0].website_endpoint, "")
      s3_bucket_website_domain              = try(aws_s3_bucket_website_configuration.s3_bucket_website_configuration[0].website_domain, "")
    }
  }
}

output "s3_result" {
  value = merge(
    local.s3_outputs.inputs,
  )
}
