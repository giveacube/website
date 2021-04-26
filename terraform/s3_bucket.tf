resource "aws_s3_bucket" "giveacube-website" {
  acl           = "private"
  bucket        = "giveacube-website-east-1"
  force_destroy = false

  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = false

      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "terraform-statefiles" {
  acl           = "private"
  bucket        = "terraform-statefiles-east-1"
  force_destroy = false

  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = false

      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
