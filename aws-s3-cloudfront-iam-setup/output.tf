output "s3_bucket_url_production" {
  description = "URL of s3 bucket"
  value       = aws_s3_bucket.s3_bucket_asset_prod.bucket_regional_domain_name
}

output "s3_bucket_url_staging" {
  description = "URL of s3 bucket"  
  value       = aws_s3_bucket.s3_bucket_asset_stag.bucket_regional_domain_name
}

