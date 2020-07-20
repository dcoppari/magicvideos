resource "aws_kms_key" "magicvideos_kms_key" {
  description = "magicvideos_kms_key"
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "magicvideos_kms_alias" {
  name          = "alias/magicvideos"
  target_key_id = aws_kms_key.magicvideos_kms_key.key_id
}

resource "aws_kms_grant" "magicvideos_kms_grant" {
  name              = "magicvideos_kms_grant"
  key_id            = aws_kms_key.magicvideos_kms_key.key_id
  grantee_principal = aws_iam_role.magicvideos_role.arn
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
}
