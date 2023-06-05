# Create IAM user
resource "aws_iam_user" "alice" {
  name = "alice"
}

resource "aws_iam_user" "malory" {
  name = "alice"
}

# Create IAM policy for /news section access
resource "aws_iam_policy" "news_policy" {
  name        = "news_policy"
  description = "Policy for /news section access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket", "s3:PutObject"],
      "Resource": [
        "${lookup(module.public_website_s3.s3_result, "s3_bucket_arn")}",
        "${lookup(module.public_website_s3.s3_result, "s3_bucket_arn")}/news/*"
      ]
    }
  ]
}
EOF
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "alice_news_attachment" {
  user       = aws_iam_user.alice.name
  policy_arn = aws_iam_policy.news_policy.arn
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "malory_news_attachment" {
  user       = aws_iam_user.malory.name
  policy_arn = aws_iam_policy.news_policy.arn
}

# Create IAM user
resource "aws_iam_user" "bobby" {
  name = "bobby"
}

# Create IAM policy for full S3 access
resource "aws_iam_policy" "full_s3_access_policy" {
  name        = "full_s3_access_policy"
  description = "Policy for full S3 access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "${lookup(module.public_website_s3.s3_result, "s3_bucket_arn")}",
        "${lookup(module.public_website_s3.s3_result, "s3_bucket_arn")}/*"
      ]
    }
  ]
}
EOF
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "bobby_attachment" {
  user       = aws_iam_user.bobby.name
  policy_arn = aws_iam_policy.full_s3_access_policy.arn
}

# Create IAM user
resource "aws_iam_user" "charlie" {
  name = "charlie"
}

# Create IAM policy for /people.html access
resource "aws_iam_policy" "people_html_policy" {
  name        = "people_html_policy"
  description = "Policy for /people.html access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket", "s3:PutObject"],
      "Resource": [
        "${lookup(module.public_website_s3.s3_result, "s3_bucket_arn")}"
        "${lookup(module.public_website_s3.s3_result, "s3_bucket_arn")}/people.html"
      ]
    }
  ]
}
EOF
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "charlie_attachment" {
  user       = aws_iam_user.charlie.name
  policy_arn = aws_iam_policy.people_html_policy.arn
}
