resource "aws_iam_role" "ec2_app_role" {
  name = "${var.project_name}-${var.environment}-ec2-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_app_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy" "artifact_bucket_read" {
  name = "${var.project_name}-${var.environment}-artifact-bucket-read"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.artifact_bucket_name}",
          "arn:aws:s3:::${var.artifact_bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "artifact_bucket_read" {
  role       = aws_iam_role.ec2_app_role.name
  policy_arn = aws_iam_policy.artifact_bucket_read.arn
}

resource "aws_iam_instance_profile" "ec2_app_profile" {
  name = "${var.project_name}-${var.environment}-ec2-app-profile"
  role = aws_iam_role.ec2_app_role.name
}