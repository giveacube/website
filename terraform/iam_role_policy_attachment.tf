resource "aws_iam_role_policy_attachment" "deployer-use-codepipeline" {
  policy_arn = aws_iam_policy.use-codepipeline.arn
  role       = "deployer"
}

resource "aws_iam_role_policy_attachment" "deployer-readonly" {
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  role       = "deployer"
}

resource "aws_iam_role_policy_attachment" "deployer-deployment" {
  policy_arn = aws_iam_policy.deployment.arn
  role       = "deployer"
}
