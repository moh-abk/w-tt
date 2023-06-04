
locals {
  # Get distinct list of domains and SANs
  distinct_domain_names = distinct(concat([var.domain_name], [for s in var.subject_alternative_names : replace(s, "*.", "")]))

  # Copy domain_validation_options for the distinct domain names
  validation_domains = var.create_certificate ? [for k, v in aws_acm_certificate.acm_certificate.domain_validation_options : tomap(v) if contains(local.distinct_domain_names, replace(v.domain_name, "*.", ""))] : []
}

locals {
  tag_defaults = {
    inputs = {
      Project_Name         = var.tag_project_name
      Environment          = var.tag_environment
      Cost_Center          = var.tag_cost_center
      App_Operations_Owner = var.tag_operations_owner
      System_Owner         = var.tag_system_owner
      Budget_Owner         = var.tag_budget_owner
      Created_By           = "Terraform"
    }
  }
}
