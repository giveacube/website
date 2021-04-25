#!/usr/bin/env bash
set -o errexit
terraform(){
  "$(brew --prefix terraform@0.13)"/bin/terraform "$@"
}

run_terraform(){
  cd ./terraform
  terraform init
  terraform apply
  cd - &> /dev/null
}

upload_to_s3(){

  aws s3 cp --only-show-errors --recursive ./static s3://giveacube-website/
}

create_cloudfront_invalidation(){
  cd ./terraform
  id=$(terraform output giveacube-website-cf-dist-id)
  aws cloudfront create-invalidation --distribution-id "$id" --path '/*'
  cd - &> /dev/null
}

run_terraform
upload_to_s3
create_cloudfront_invalidation