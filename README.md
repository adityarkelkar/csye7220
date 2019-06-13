# Deployment of Software Applications - CSYE 7220 Midterm Project

### Problem Statement
- Write a CI/CD engine that spans Azure and AWS: It builds on one Cloud and deploys and runs on the other. 
- You can pick the coding language, the Web site tech stack, and the CI/CD toolset. The Web site shall consist of a song lyrics Web site with at least one picture. 
- You will demonstrate the following scenario: You will rebuild the Web site with the least amount of mouse and keyboard movement (caching the different Web pages is allowed). 
- The rebuild will trigger a deployment and eventually lead to a new song lyric Web page when the browser is refreshed.

### Requirements
- Github account
- A standalone/shared jenkins server
- AWS console and Azure portal accounts with root privileges

### Project Flow
Below is a brief idea about the flow of the Ci/CD pipeline
1. User makes a push to git
2. Github hook will trigger an automated jenkins job which will build the project using AWS CodeBuild CI service
3. Once the project is built, the generated artifact war file will be placed in an S3 bucket
4. We set up an S3 push event notifying Simple Queue Service
5. Jenkins will now trigger a second job from the SQS and export the artifact from S3 to Azure Blob Storage service
6. Once that is done, Jenkins will deplpoy that artifact on a pre provisioned Azure VM and we will see our code successfully by accessing the public IP of that VM on port 8080

### Web Server Prerequisites
1. We will require a fully functional EC2 instance with Jenkins, Java, AWS CLI and Azure CLI installed
2. We will also require a pre provisioned Azure VM with Azure CLI pre-installed

### Jenkins Build Jobs
We have two jenkins build jobs which will run customized shell scripts. More on this in other sections


### Important Steps
1. To setup github webhook with the payload URL as `http://{YOUR_JENKINS_IRL}:{PORT}/github-webhook/` and make sure we receive a response 200 for the sample request
2. We need to setup different plugins within jenkins for both AWS and Azure. More on this in the other sections