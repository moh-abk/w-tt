#--------------------------------------------------------------
# S3 Remote State
#--------------------------------------------------------------

data "terraform_remote_state" "remote_state" {
  backend = "s3"

  config = {
    bucket   = var.bucket
    key      = var.key
    region   = var.aws_region
    role_arn = var.role_arn
  }
}
