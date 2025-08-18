provider "aws" { region = var.aws_region }

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "this" {
  bucket = "developer-hub-${var.bucket_name}-${random_id.suffix.hex}"

  tags = {
    Name        = "${var.bucket_name}"
    CreatedBy   = "developer-hub"
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule { object_ownership = "BucketOwnerEnforced" }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration { status = var.versioning_on ? "Enabled" : "Suspended" }
}

output "bucket_name" { value = aws_s3_bucket.this.bucket }
output "bucket_arn"  { value = aws_s3_bucket.this.arn }
