module "public_website_cloudfront" {
  source = "../../../../../modules/aws/tfm-aws-cloudfront"

  aliases = [var.public_website_domain_name]

  create_origin_access_control = true
  origin_access_control = {
    s3_oac = {
      description      = "CloudFront access to S3"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  origin = {
    s3_one = {
      domain_name           = lookup(module.public_website_s3.s3_result, "s3_bucket_bucket_domain_name")
      origin_access_control = "s3_oac"
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3_one"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true

    min_ttl     = 3600
    default_ttl = 86400
    max_ttl     = 172800
  }

  viewer_certificate = {
    acm_certificate_arn      = lookup(module.public_website_s3_acm.acm_result, "certificate_arn")
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
}

resource "aws_route53_record" "jwks_cname" {
  zone_id = var.zone_id
  name    = var.public_website_domain_name
  type    = "CNAME"
  ttl     = "30"
  records = [
    module.public_website_cloudfront.cloudfront_distribution_domain_name
  ]
}
