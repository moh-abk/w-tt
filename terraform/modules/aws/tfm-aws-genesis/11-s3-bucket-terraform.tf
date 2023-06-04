#--------------------------------------------------------------
# Genesis - Terraform Bucket
#--------------------------------------------------------------

resource "aws_s3_bucket" "s3_bucket_terraform" {
  bucket = lower(format("%s-infrastructure-terraform",
    data.aws_caller_identity.current.account_id
  ))

  provider = aws.eu-west-1
  acl      = var.s3_bucket_acl
  policy   = data.template_file.terraform_s3_bucket_policy_document.rendered

  versioning {
    enabled = true
  }

  force_destroy = true

  # Accept all tags by default and only replace the name
  tags = merge(
    tomap({
      "Name" = lower(format("%s-infrastructure-terraform",
        data.aws_caller_identity.current.account_id
      ))
    })
  )

  replication_configuration {
    role = aws_iam_role.replication_iam_role.arn

    rules {
      id = lower(format("%s-infrastructure-terraform",
        data.aws_caller_identity.current.account_id
      ))

      prefix = ""
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.s3_bucket_terraform_replica.arn
        storage_class = "STANDARD"
      }
    }
  }
}

data "template_file" "terraform_s3_bucket_policy_document" {
  vars = {
    s3_bucket_name = lower(format("%s-infrastructure-terraform",
      data.aws_caller_identity.current.account_id
    ))
  }

  template = file("${path.module}/templates/default_s3_bucket_policy.json.tpl")
}
