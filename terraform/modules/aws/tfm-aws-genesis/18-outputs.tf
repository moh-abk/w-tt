locals {
  dynamodb_outputs = {
    inputs = {
      dynamodb_arn = aws_dynamodb_table.terraform_dynamodb_table.arn
    }
  }

  s3_outputs = {
    inputs = {
      terraform_s3_bucket_id          = aws_s3_bucket.s3_bucket_terraform.id
      terraform_s3_bucket_arn         = aws_s3_bucket.s3_bucket_terraform.arn
      terraform_s3_bucket_domain_name = aws_s3_bucket.s3_bucket_terraform.bucket_domain_name

      terraform_replica_s3_bucket_id          = aws_s3_bucket.s3_bucket_terraform_replica.id
      terraform_replica_s3_bucket_arn         = aws_s3_bucket.s3_bucket_terraform_replica.arn
      terraform_replica_s3_bucket_domain_name = aws_s3_bucket.s3_bucket_terraform_replica.bucket_domain_name
    }
  }
}

output "genesis_result" {
  value = merge(
    local.dynamodb_outputs.inputs,
    local.s3_outputs.inputs,
  )
}
