
output "aws_iam_access_key" {
  value = aws_iam_access_key.magicvideos_key.id
}

output "aws_iam_access_secret" {
  value = aws_iam_access_key.magicvideos_key.secret
}

output "aws_elastictranscoder_pipeline" {
  value = aws_elastictranscoder_pipeline.magicvideos_pipeline.id
}

output "aws_elastictranscoder_preset_sd" {
  value = aws_elastictranscoder_preset.magicvideos_sd_preset.id
}

output "aws_elastictranscoder_preset_hd" {
  value = aws_elastictranscoder_preset.magicvideos_hd_preset.id
}

output "aws_cloudfront_distribution_domain" {
  value = aws_cloudfront_distribution.magicvideos_distribution.domain_name
}
