#! /bin/bash

zaws_init() {
  # This file is required w/ aws creds configured 
  # Also note, you need to run 'aws configure' to set up the 'zeeaws' profile 
  source ~/.zaws

  export AWS_DEFAULT_PROFILE=zeeaws

  # Setup aws cli 
  aws configure set aws_access_key_id $AWS_ACCESS_KEY --profile zeeaws
  aws configure set aws_secret_access_key $AWS_SECRET_KEY --profile zeeaws

  # Run test
  #aws s3 ls
  #aws ec2 describe-instances
}