#!/usr/bin/env bash
set -o errexit

install_terraform(){
  cd ./terraform
  curl --fail --output tf.zip --silent \
    "https://releases.hashicorp.com/terraform/0.13.6/terraform_0.13.6_linux_amd64.zip"
  unzip -qo tf.zip
  chmod +x tf.zip
  cd - &> /dev/null
}

run_terraform(){
  cd ./terraform
  ./terraform init -no-color
  ./terraform apply -auto-approve -no-color
  cd - &> /dev/null
}

upload_to_s3(){
  aws s3 cp --only-show-errors --recursive ./static s3://giveacube-website-east-1/
}

create_cloudfront_invalidation(){
  cd ./terraform
  id=$(./terraform output -no-color giveacube-website-cf-dist-id)
  aws cloudfront create-invalidation --distribution-id "$id" --path '/*'
  cd - &> /dev/null
}

install_terraform
run_terraform
upload_to_s3
create_cloudfront_invalidation