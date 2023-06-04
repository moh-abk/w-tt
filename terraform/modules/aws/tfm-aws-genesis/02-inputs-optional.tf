# Common inputs for multiple resources
variable "tags" {
  description = "A map of individual tags. Some default tags will also be applied"
  type        = map(string)
  default     = {}
}

# Default ACL to apply to S3 buckets
variable "s3_bucket_acl" {
  default = "private"
}
