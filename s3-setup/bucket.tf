  resource "aws_s3_bucket" "s3_bucket_asset_prod" {
      bucket        = "${var.prod_bucket_name}"
      acl     = "${var.acl_value}"
      server_side_encryption_configuration {
        rule {
          apply_server_side_encryption_by_default {
            sse_algorithm = "aws:kms"
          }
        }
      }
      cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT", "POST", "GET"]
        allowed_origins = ["*"]
      }
      tags = {
        project = "${var.tags}"
      } 

  }

    resource "aws_s3_bucket" "s3_bucket_asset_stag" {
      bucket      = "${var.stag_bucket_name}"
      acl   = "${var.acl_value}"
      server_side_encryption_configuration {
        rule {
          apply_server_side_encryption_by_default {
            sse_algorithm = "aws:kms"
          }
        }
      }
      cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT", "POST", "GET"]
        allowed_origins = ["*"]
      }
      tags = {
        project = "${var.tags}"
      }
  }

resource "aws_cloudfront_distribution" "s3_bucket_asset_prod" {
  origin {
    domain_name = aws_s3_bucket.s3_bucket_asset_prod.bucket_regional_domain_name
    origin_id   = "${var.production_origin_id}"
  }

  enabled             = true
  is_ipv6_enabled     = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    cache_policy_id  = "Managed-CachingOptimized"
    origin_request_policy_id = "Managed-CORS-S3Origin"
    target_origin_id = "${var.production_origin_id}"
    viewer_protocol_policy = "redirect-to-https"
    
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  tags = {
    project = "${var.tags}"
  }

}

resource "aws_cloudfront_distribution" "s3_bucket_asset_stag" {
  origin {
    domain_name = aws_s3_bucket.s3_bucket_asset_stag.bucket_regional_domain_name
    origin_id   = "${var.staging_origin_id}"
  }

  enabled             = true
  is_ipv6_enabled     = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    cache_policy_id  = "Managed-CachingOptimized"
    origin_request_policy_id = "Managed-CORS-S3Origin"
    target_origin_id = "${var.staging_origin_id}"
    viewer_protocol_policy = "redirect-to-https"
    
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  tags = {
    project = "${var.tags}"
  }

}
