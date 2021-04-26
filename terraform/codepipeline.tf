# aws_codepipeline.deploy:
resource "aws_codepipeline" "deploy" {
  name     = "deploy"
  role_arn = "arn:aws:iam::569372380844:role/service-role/deployer"

  artifact_store {
    location = "codepipeline-us-east-1-619219611898"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      category = "Source"

      configuration = {
        "BranchName"           = "main"
        "ConnectionArn"        = "arn:aws:codestar-connections:us-east-2:569372380844:connection/f0c51843-892b-4d7c-8e8e-fdf6eba65a70"
        "FullRepositoryId"     = "giveacube/website"
        "OutputArtifactFormat" = "CODE_ZIP"
      }

      input_artifacts = []
      name            = "Source"
      namespace       = "SourceVariables"

      output_artifacts = [
        "SourceArtifact",
      ]

      owner     = "AWS"
      provider  = "CodeStarSourceConnection"
      region    = "us-east-1"
      run_order = 1
      version   = "1"
    }
  }

  stage {
    name = "Build"

    action {
      category = "Build"

      configuration = {
        "ProjectName" = "deploy"
      }

      input_artifacts = [
        "SourceArtifact",
      ]

      name      = "Build"
      namespace = "BuildVariables"

      output_artifacts = [
        "BuildArtifact",
      ]

      owner     = "AWS"
      provider  = "CodeBuild"
      region    = "us-east-1"
      run_order = 1
      version   = "1"
    }
  }
}
