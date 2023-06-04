#--------------------------------------------------------------
# Genesis - DynamoDB
#--------------------------------------------------------------

resource "aws_dynamodb_table" "terraform_dynamodb_table" {
  name = lower(format("%s-infrastructure-terraform",
    data.aws_caller_identity.current.account_id
  ))

  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(
    tomap({
      "Name" = lower(format("%s-infrastructure-terraform",
        data.aws_caller_identity.current.account_id
      ))
    })
  )
}
