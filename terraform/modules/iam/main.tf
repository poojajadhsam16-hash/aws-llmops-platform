# Trust policy: allow EC2 to assume this role
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Application IAM role
resource "aws_iam_role" "app" {
  name = "${var.project_name}-app-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Project = var.project_name
    Environment = "dev"
  }
}

# Read-only access to the project's S3 bucket
data "aws_iam_policy_document" "s3_read" {
  statement {
    sid = "ListDocumentsBucket"
    effect = "Allow"
    actions = ["s3:ListBucket"]
    resources = [var.bucket_arn]
  }

  statement {
    sid = "ReadDocumentObjects"
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${var.bucket_arn}/*"]
  }
}

# Attach the policy to the application role
resource "aws_iam_role_policy" "s3_read" {
  name = "${var.project_name}-s3-read"
  role = aws_iam_role.app.id
  policy = data.aws_iam_policy_document.s3_read.json
}

resource "aws_iam_instance_profile" "app" {
  name = "${var.project_name}-app-instance-profile"
  role = aws_iam_role.app.name

  tags = {
    Project = var.project_name
    Environment = "dev"
  }
}
