# S3 bucket for website.
resource "aws_s3_bucket" "romuluscloud_bucket" {
  bucket = "romuluscloud"

  tags = {
    Name = "romuluscloud"
    Environment = "Dev"
    }
  force_destroy = true
  }

resource "aws_s3_bucket_website_configuration" "romuluscloud_website" {
  bucket = aws_s3_bucket.romuluscloud_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}



# S3 Allow Public read access as data object
# secure the bucket that you are creating from public acess

resource "aws_s3_bucket_public_access_block" "romuluscloud_bucket" {
    bucket = aws_s3_bucket.romuluscloud_bucket.bucket
    block_public_acls = true 
    block_public_policy = true 
    ignore_public_acls = true 
    restrict_public_buckets = true 
}


resource "aws_s3_bucket_server_side_encryption_configuration" "romuluscloud_bucket" {
    bucket = aws_s3_bucket.romuluscloud_bucket.bucket
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}



resource "aws_s3_bucket_versioning" "romuluscloud_bucket" {
  bucket = aws_s3_bucket.romuluscloud_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}



resource "aws_s3_object" "content" {

  depends_on = [
    aws_s3_bucket.romuluscloud_bucket
  ]

  bucket = aws_s3_bucket.romuluscloud_bucket.bucket
  key    = "index.html" 
  source = "./index.html" 
  server_side_encryption = "AES256" 
  content_type = "text/html" 
}


resource "aws_s3_object" "cleavage1" {
  depends_on = [
    aws_s3_bucket.romuluscloud_bucket
  ]

  bucket = aws_s3_bucket.romuluscloud_bucket.bucket
  key    = "cleavage1.jpg"
  source = "/Users/Teddy/TerraformFolder/AWS/Romulus_S3_CloudFront/cleavage1.jpg"
  server_side_encryption = "AES256"
  content_type = "image/jpg"

}

resource "aws_s3_object" "cleavage2" {
  depends_on = [
    aws_s3_bucket.romuluscloud_bucket
  ]

  bucket = aws_s3_bucket.romuluscloud_bucket.bucket
  key    = "cleavage2.jpg"
  source = "/Users/Teddy/TerraformFolder/AWS/Romulus_S3_CloudFront/cleavage2.jpg"
  server_side_encryption = "AES256"
  content_type = "image/jpg"

}

resource "aws_s3_object" "cleavage3" {
  depends_on = [
    aws_s3_bucket.romuluscloud_bucket
  ]

  bucket = aws_s3_bucket.romuluscloud_bucket.bucket
  key    = "cleavage3.jpg"
  source = "/Users/Teddy/TerraformFolder/AWS/Romulus_S3_CloudFront/cleavage3.jpg"
  server_side_encryption = "AES256"
  content_type = "image/jpg"

}

resource "aws_s3_object" "cleavage4" {
  depends_on = [
    aws_s3_bucket.romuluscloud_bucket
  ]

  bucket = aws_s3_bucket.romuluscloud_bucket.bucket
  key    = "cleavage4.jpg"
  source = "/Users/Teddy/TerraformFolder/AWS/Romulus_S3_CloudFront/cleavage4.jpg"
  server_side_encryption = "AES256"
  content_type = "image/jpg"

}