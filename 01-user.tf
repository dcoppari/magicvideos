resource "aws_iam_group" "magicvideos_group" {
  name = "magicvideos_group"
  path = "/"
}

resource "aws_iam_group_policy" "magicvideos_group_policy" {
  name  = "magicvideos_group_policy"
  group = aws_iam_group.magicvideos_group.id
  policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": [
                "medialive:*",
                "mediaconvert:*",
                "mediapackage:*",
                "mediatailor:*",
                "elastictranscoder:*",
                "cloudfront:*",
                "s3:List*",
                "s3:Put*",
                "s3:Get*",
                "s3:CreateBucket",
                "s3:*MultipartUpload*",
                "iam:CreateRole",
                "iam:GetRole",
                "iam:PassRole",
                "iam:PutRolePolicy",
                "ssm:PutParameter",
                "kms:List*"
            ],
            "Effect": "Allow",
            "Resource": "*"
            }
        ]
    }
    EOF
}

resource "aws_iam_group_membership" "magicvideos_members" {
  name = "magicvideos_members"
  users = [ aws_iam_user.magicvideos_user.name ]
  group = aws_iam_group.magicvideos_group.name
}

resource "aws_iam_role_policy_attachment" "magicvideos_role_policy_attach" {
  role       = aws_iam_role.magicvideos_role.name
  policy_arn = aws_iam_policy.magicvideos_policy.arn
}

resource "aws_iam_role" "magicvideos_role" {
  name = "magicvideos_role"
  assume_role_policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "1",
                "Effect": "Allow",
                "Principal": {
                    "Service": "elastictranscoder.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    EOF
}

resource "aws_iam_policy" "magicvideos_policy" {
  name        = "magicvideos_policy"
  policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "1",
                "Effect": "Allow",
                "Action": [
                    "s3:Put*",
                    "s3:ListBucket",
                    "s3:*MultipartUpload*",
                    "s3:Get*"
                ],
                "Resource": "*"
            },
            {
                "Sid": "2",
                "Effect": "Allow",
                "Action": "sns:Publish",
                "Resource": "*"
            },
            {
                "Sid": "3",
                "Effect": "Deny",
                "Action": [
                    "s3:*Delete*",
                    "s3:*Policy*",
                    "sns:*Remove*",
                    "sns:*Delete*",
                    "sns:*Permission*"
                ],
                "Resource": "*"
            }
        ]
    }
    EOF
}

resource "aws_iam_user" "magicvideos_user" {
  name = "magicvideos_user"
  path = "/"
}

resource "aws_iam_access_key" "magicvideos_key" {
  user = aws_iam_user.magicvideos_user.name
}
