#! /bin/bash

awsS3MakeBucket() { 
  zaws_init
  echo "Making bucket... ${0}"
  # aws s3 mb s3://zkube.zee-aws.net
  # export KOPS_STATE_STORE=s3://zkube.zee-aws.net
  # kops create cluster --zones=us-west-2 zkube-cluster.zee-aws.net --ssh-public-key ~/.ssh/kops.pub
  # 
  aws s3 mb "${0}"
}