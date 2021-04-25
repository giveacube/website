resource "aws_iam_user_policy_attachment" "deployer-assume-deployer" {
  policy_arn = aws_iam_policy.assume-deployer.arn
  user       = aws_iam_user.deployer.name
}
