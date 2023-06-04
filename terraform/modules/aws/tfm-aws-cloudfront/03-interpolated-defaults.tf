locals {
  create_origin_access_identity = var.create_origin_access_identity && length(keys(var.origin_access_identities)) > 0
  create_origin_access_control  = var.create_origin_access_control && length(keys(var.origin_access_control)) > 0
}
