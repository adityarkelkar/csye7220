## Required Plugins for Jenkins

### Apart from the default/out-of-the-box installed plugins in jenkins, following is a list of other plugins you will need to manually install once you have your Jenkins instance up and running

1.	AWS Global Configuration Plugin
2.	AWS SQS Build Trigger Plugin
3.	Azure Artifact Manager plugin
4.	Azure CLI Plugin
5.	GitHub Authentication plugin
6.	Windows Azure Storage plugin


### Other Requirements
You will have to SSH into your jenkins server and install java, AWS CLI, Azure CLI (You could leverage EC2 user-data if required to automate the process further)