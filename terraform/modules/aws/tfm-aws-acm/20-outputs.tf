#--------------------------------------------------------------
# Outputs
#--------------------------------------------------------------

locals {
  acm_outputs = {
    inputs = {
      zone_id         = var.zone_id
      domain_name     = var.domain_name
      certificate_arn = element(concat(aws_acm_certificate_validation.acm_certificate_validation.*.certificate_arn, aws_acm_certificate.acm_certificate.*.arn, [""]), 0)
    }
  }
}

output "acm_result" {
  value = merge(
    local.acm_outputs.inputs,
  )
}
