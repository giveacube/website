resource "aws_iam_role" "deployer" {
  assume_role_policy = <<POLICY
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.deployer.arn}",
        "Service": "codepipeline.amazonaws.com"
      }
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  managed_policy_arns = [
    aws_iam_policy.deployment.arn,
    aws_iam_policy.use-codepipeline.arn,
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
  ]

  max_session_duration = "3600"
  name                 = "deployer"
  path                 = "/service-role/"
}
