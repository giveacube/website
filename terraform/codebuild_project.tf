resource "aws_codebuild_project" "deploy" {
  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/giveacube/website.git"
    git_clone_depth = 1
    buildspec = <<EOT
version: 0.2

phases:
  build:
    commands:
       - ./deploy.sh
    EOT
  }

  name = "deploy"
  source_version = "main"
  build_timeout = "15"
  service_role = aws_iam_role.deployer.arn
}