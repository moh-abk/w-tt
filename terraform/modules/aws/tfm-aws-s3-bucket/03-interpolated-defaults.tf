data "aws_caller_identity" "current" {}
data "aws_canonical_user_id" "this" {}

locals {
  attach_policy = var.attach_require_latest_tls_policy || var.attach_elb_log_delivery_policy || var.attach_lb_log_delivery_policy || var.attach_deny_insecure_transport_policy || var.attach_policy

  # Variables with type `any` should be jsonencode()'d when value is coming from Terragrunt
  grants              = try(jsondecode(var.grant), var.grant)
  cors_rules          = try(jsondecode(var.cors_rule), var.cors_rule)
  lifecycle_rules     = try(jsondecode(var.lifecycle_rule), var.lifecycle_rule)
  intelligent_tiering = try(jsondecode(var.intelligent_tiering), var.intelligent_tiering)
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
      Service              = var.tag_service
      Created_By           = "Terraform"
    }
  }
}
