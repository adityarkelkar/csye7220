#!/bin/bash
# To check the required plugins for Jenkins, refer README.md file

export CODEBUILD_PROJECT="csye7220-webapp"
export AWS_REGION="us-east-1"

aws codebuild start-build --project ${CODEBUILD_PROJECT} --region ${AWS_REGION}