#!/bin/bash -ex

# System update
sudo yum update -y

# Install java
sudo yum install java-1.8.0-openjdk -y
sudo yum install java-1.8.0-openjdk-devel -y
java -version

# Install wget
sudo yum install wget -y

# Install python pip
sudo yum install epel-release -y
sudo yum repolist -y
sudo yum install python-pip -y
pip --version
sudo yum install python-devel -y
sudo yum groupinstall 'development tools' -y

# Install jenkins
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key -y
sudo yum install jenkins -y
sudo systemctl start jenkins
systemctl status jenkins
sudo systemctl enable jenkins

