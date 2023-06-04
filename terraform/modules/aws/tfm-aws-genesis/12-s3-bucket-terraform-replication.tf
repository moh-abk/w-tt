#--------------------------------------------------------------
# Genesis - Terraform Replication Bucket
#--------------------------------------------------------------

resource "aws_iam_role" "replication_iam_role" {
  name = format("%s_role_TerraformBucketReplication", data.aws_caller_identity.current.account_id)

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "replication" {
  name = format("%s_policy_TerraformBucketReplication", data.aws_caller_identity.current.account_id)

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.s3_bucket_terraform.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.s3_bucket_terraform.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.s3_bucket_terraform_replica.arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "replication" {
  name = format("%s_policyattachment_TerraformBucketReplication", data.aws_caller_identity.current.account_id)

  roles = [
    aws_iam_role.replication_iam_role.name,
  ]

  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_s3_bucket" "s3_bucket_terraform_replica" {
  bucket = lower(format("%s-infrastructure-terraform-replica",
    data.aws_caller_identity.current.account_id
  ))

  provider = aws.us-east-1
  acl      = var.s3_bucket_acl
  policy   = data.template_file.terraform_s3_replica_policy_document.rendered

  force_destroy = true

  versioning {
    enabled = true
  }

  # Accept all tags by default and only replace the name
  tags = merge(
    tomap({
      "Name" = lower(format("%s-infrastructure-terraform-replica",
        data.aws_caller_identity.current.account_id
      ))
    })
  )
}

data "template_file" "terraform_s3_replica_policy_document" {
  vars = {
    s3_bucket_name = lower(format("%s-infrastructure-terraform-replica",
      data.aws_caller_identity.current.account_id
    ))
  }

  template = file("${path.module}/templates/default_s3_bucket_policy.json.tpl")
}
