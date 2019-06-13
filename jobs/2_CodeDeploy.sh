#!/bin/bash
# To check the required plugins for Jenkins, refer README.md file
# Note: The env variables here do not work with jobs triggered through SQS
# You may need to enter hardcoded values

echo "Hello World"
export S3_BUCKET="csye7220-midterm-codedeploy"
export AZURE_STORAGE_CONTAINER="csye7220-midterm-codedeploy"
export ARTIFACT_NAME="csye7220app-0.0.1-SNAPSHOT.war"



aws s3 cp s3://${S3_BUCKET}/ ./ --recursive
aws s3 rm s3://${S3_BUCKET} --recursive

cd csye7220-webapp/
az login --service-principal --username "${AZURE_CLIENT_ID}" --password "${AZURE_CLIENT_SECRET}" --tenant "${AZURE_TENANT_ID}"
az storage account list
az storage blob upload --container-name ${AZURE_STORAGE_CONTAINER} --name ${ARTIFACT_NAME} --file ${ARTIFACT_NAME} --account-name "${AZURE_STORAGE_ACCOUNT_NAME}" --account-key "${AZURE_STORAGE_ACCOUNT_KEY}"

ssh -v -i "${SSH_KEYFILE}" "${SSH_USER}"@"${PUBLIC_IP}" -o StrictHostKeyChecking=no << EOF
cd webapp
rm ${ARTIFACT_NAME}
rm tomcat.log
sudo fuser -k -n tcp 8080

az storage blob download --container-name ${AZURE_STORAGE_CONTAINER} --file ${ARTIFACT_NAME} --name ${ARTIFACT_NAME} --account-name "${AZURE_STORAGE_ACCOUNT_NAME}" --account-key "${AZURE_STORAGE_ACCOUNT_KEY}"
java -jar ${ARTIFACT_NAME} &> tomcat.logs &

EOF