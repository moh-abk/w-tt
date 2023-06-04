output "public_website_result" {
  value = merge(
    module.public_website_s3.s3_result,
    module.public_website_s3_acm.acm_result,
    tomap({
      "cloudfront_distribution_domain_name" = module.public_website_cloudfront.cloudfront_distribution_domain_name
    }),
  )
}
