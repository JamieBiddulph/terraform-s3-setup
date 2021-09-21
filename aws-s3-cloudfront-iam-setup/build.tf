################################################
###### Create s3 Asset buckets #################
################################################
  
  resource "aws_s3_bucket" "s3_bucket_asset_prod" {
      bucket        = "${var.prod_bucket_assets_name}"
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
      bucket      = "${var.stag_bucket_assets_name}"
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

################################################
###### Create s3 storage buckets ###############
################################################

  resource "aws_s3_bucket" "s3_bucket_prod" {
      bucket        = "${var.prod_bucket_storage_name}"
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

    resource "aws_s3_bucket" "s3_bucket_stag" {
      bucket      = "${var.stag_bucket_storage_name}"
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

################################################
###### Create CloudFront Distributions #########
################################################

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
    cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    origin_request_policy_id = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"
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
    cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    origin_request_policy_id = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"
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

############################
###### Add IAM policies ####
############################

resource "aws_iam_policy" "s3_bucket_asset_policy" {
  name        = "s3_bucket_asset_policy"
  
  tags = {
    project = "${var.tags}"
  }

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Statement = [
      {
        #Add actual policy
        # Action = [
        #   "ec2:Describe*",
        # ]
        # Effect   = "Allow"
        # Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "cloudfront_prod_policy" {
  name        = "cloudfront_prod_policy"
  
  tags = {
    project = "${var.tags}"
  }

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Statement = [
      {
        #Add actual policy
        # Action = [
        #   "ec2:Describe*",
        # ]
        # Effect   = "Allow"
        # Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "cloudfront_stag_policy" {
  name        = "cloudfront_stag_policy"
  
  tags = {
    project = "${var.tags}"
  }

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Statement = [
      {
        #Add actual policy
        # Action = [
        #   "ec2:Describe*",
        # ]
        # Effect   = "Allow"
        # Resource = "*"
      },
    ]
  })
}

########################
###### Add IAM user ####
########################

resource "aws_iam_user" "client-project-iam" {
  name = "client-project-iam"

  tags = {
    project = "${var.tags}"
  }
}

resource "aws_iam_access_key" "client-project-iam" {
  user = aws_iam_user.client-project-iam.name
}

#######################################
###### Attach policies to IAM user ####
#######################################

resource "aws_iam_user_policy_attachment" "client-project-iam-attach-s3_bucket_asset_policy" {
  user       = aws_iam_user.client-project-iam.name
  policy_arn = aws_iam_policy.s3_bucket_asset_policy.arn
}

resource "aws_iam_user_policy_attachment" "client-project-iam-attach-cloudfront_prod_policy" {
  user       = aws_iam_user.client-project-iam.name
  policy_arn = aws_iam_policy.cloudfront_prod_policy.arn
}

resource "aws_iam_user_policy_attachment" "client-project-iam-attach-cloudfront_stag_policy" {
  user       = aws_iam_user.client-project-iam.name
  policy_arn = aws_iam_policy.cloudfront_stag_policy.arn
}