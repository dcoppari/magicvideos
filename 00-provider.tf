variable aws_region {}
variable aws_access_key {}
variable aws_secret_key {}
variable aws_bucket_name {}

provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
