# k8s-ops

## Objective
- This is a self made project wherein I will attempt to setup a fully functional, highly available kubernetes cluster based off AWS
- I will make use of the KOPS tool to spin up the cluster along with the kubernetes dashboard for the same
- I will attempt to manage all the infrastructure using ansible by defining various roles for various purposes

## Prerequisites
1. <a href="https://github.com/kubernetes/kops/blob/master/docs/install.md">**KOPS**</a>
2. <a href="https://docs.aws.amazon.com/cli/latest/userguide/cli-install-macos.html">**AWS CLI**</a>
3. <a href="https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-using-native-package-management">**kubectl**</a>
4. <a href="https://docs.docker.com/install/">**Docker**</a>
5. <a href="https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html">**Ansible**</a>

*I will be using a Ubuntu 64bit operating system to run all operations. All the instructions hereby will be keeping this same OS in mind*

## TL;DR
- Clone this repository to your local system and run the `ansible-playbook` command for the required yaml files in the project root
- I have defined a playbook for deploying a k8s cluster off AWS. Once the cluster is deployed and validated, I have an additional playbook to deploy the kubernetes dashboard
- I have also defined a cluster teardown playbook which will get rid of all the kubernetes resources that have been deployed so far
- Additionally, I have a simple playbook that will check the pre requisites on the system where we will run these playbooks

## From Scratch Setup
*Follow these steps if you need to understand how to create a new role and how to call these roles to perform a playbook task*
- To follow along with the operations mentioned in this project, create an empty directory called `k8s-ops` in your local system using the command
```
mkdir k8s-ops
```
*Note: You may name this directory as you wish. I am naming it k8s-ops and will follow this convention throughout the project*
- Now go into this directory, create an empty directory called `roles`. This directory will be used to hold the various role based playbook tasks that you might need to perform from time to time

## Basic Ansible Playbook Operations
#### Use Case
```
I need to create a role which will perform initial checks on my local system to check if the prerequisites like awscli, docker etc are available and functional
```
#### Current folder structure
- Navigate to the `roles` directory. Now type the command to create a new role called `prereqs`
```
ansible-galaxy init prereqs
```
We will now have a role called `prereqs` that has been created. The folder tree structure at this moment will look something like this
```
k8s-ops/
└── roles
    └── prereqs
        ├── defaults
        │   └── main.yml
        ├── files
        ├── handlers
        │   └── main.yml
        ├── meta
        │   └── main.yml
        ├── README.md
        ├── tasks
        │   └── main.yml
        ├── templates
        ├── tests
        │   ├── inventory
        │   └── test.yml
        └── vars
            └── main.yml
```
- Next, we will write the tasks that need to be performed by the `prereqs` role. Navigate to the tasks folder and edit the `main.yml` file like this
```
vim roles/prereqs/tasks/main.yml
```
*Note: Feel free to use any text editor you prefer*
- Enter the following lines of code in the file
```
---
# tasks file for prereqs

- name: update system
  shell: apt update
  become: yes

- name: List all upgradables
  command: apt list --upgradable
  become: yes

- name: List all aws s3 buckets, check aws cli
  command: aws s3 ls
  
- name: List all docker images
  command: '{{ item }}'
  with_items:
    - docker ps -al
    - docker images
  become: yes
```
- Some quick explainations for the keywords used in the above code
    + `name`: Name of the task. This will show up in the terminal when you run the playbook
    + `shell/command`: Contains the commands that we will run on the host machine
    + `become`: Previlege escalation. Allows ansible to **become** another user. For ex. we need to run the commands as root user
*For more details regarding such keywords, refer <a href="https://docs.ansible.com/ansible/latest/reference_appendices/playbooks_keywords.html">**THIS**</a> link*
- We have now successfully created a role to execute prerequisites check on the host

#### Running the playbook
- To run a playbook, I am going to define a separate playbook yaml file in the project root. This yaml will name the role that has to be executed and will run the playbook accordingly
- Go to the project root and create a new yaml file called `create_k8s.yml`
- Put in the following code inside this yaml file
```
---
# tasks file for create k8s

- hosts: localhost
  become: yes
  tasks:
  - include_role:
      name: prereqs
```
- Some quick explainations for the keywords used in the above code
    + `hosts`: The host that our playbook is targetting. Since we are running all commands on local system, the host here is localhost
    + `tasks`: Main list of tasks that are to be executed in the play
    + `include_role`: The role that we need to include that will run the task; in this case `prereqs`
- Once done, run the following command in the terminal
```
ansible-playbook create_k8s.yml -vvv
```
*-vvv will create a verbose output in the terminal*

## KOPS related operations
#### Use Case
```
I need to define roles that will create and teardown a kops cluster on AWS
```
#### Creating roles
- As mentioned in the preceding use case, create two new roles `kops-create` and `kops-teardown` inside the roles directory

#### Updated folder structure
```
roles
├── kops-create
│   ├── defaults
│   ├── files
│   ├── handlers
│   ├── meta
│   ├── README.md
│   ├── tasks
│   ├── templates
│   ├── tests
│   └── vars
├── kops-teardown
│   ├── defaults
│   ├── files
│   ├── handlers
│   ├── meta
│   ├── README.md
│   ├── tasks
│   ├── templates
│   ├── tests
│   └── vars
└── prereqs
    ├── defaults
    ├── files
    ├── handlers
    ├── meta
    ├── README.md
    ├── tasks
    ├── templates
    ├── tests
    └── vars
```
- Next, inside the respective task yaml files of both `kops-create` and `kops-teardown`, add the following code
Create
```
---
# tasks file for kops-create

- name: Run kops create command
  command: kops create cluster --zones {{ cluster_zone }} --node-count={{ node_count }} --node-size t2.micro --master-size t2.micro --name {{ cluster_name }} --state {{ kops_state_store }} --yes
  become: yes
```
Teardown
```
---
# tasks file for kops-teardown

- name: Teardown a k8s cluster
  command: kops delete cluster --name {{ cluster_name }} --state {{ kops_state_store }} --yes
  become: yes
```
- As you may have noticed, we have specified certain variables in these files. These variables will be defined in the `create_k8s.yml` file in the project root. Add the following code to this file
```
---
# tasks file for create k8s

- hosts: localhost
  become: true
  tasks:
  - include_role:
      name: prereqs

- hosts: localhost
  become: true
  tasks:
  - include_role:
      name: kops-create

  vars:
    cluster_zone: us-east-1a
    node_count: 3
    cluster_name: k8s.local
    kops_state_store: s3://k8slab.csye6225-spring2018-kelkaradi.me
```
- As shown above, out `create_k8s.yml` will now run tasks defined in two roles i.e. `prereqs` and `kops-create`
- The variables are now defined in a separate section called `vars`
- Run these playbooks as and when needed


#### Use Case
```
I need to deploy the kubernetes dashboard once my cluster is ready
```

#### Required files/scripts
- I added a new folder in the project root called `k8s`. This folder contains three files, `create-service-account.yaml`, `cluster-role-binding.yaml` and `deployscript.sh`
- The yaml files are the kube templates to create a service account and a role binding that account
- The shell script will execute all the operations required to deploy the dashboard. These actions can be performed as individual tasks as a part of the dashboard role.
- I found it easier to just run the script that will deploy everything as required

#### Create roles
- Next, create a new role `kops-dashboard`
- Following code will be added in the tasks for this role
```
---
# tasks file for kops-dashboard

- name: "Deploy dashboard: Run the deploy script"
  become: yes
  shell: sh {{ playbook_dir }}/k8s/deployscript.sh
```
- As the script runs, all the further actions required from the user end will be displayed as output result of the playbook execution

##### ***Important pointers*** 
- In order to get the dashboard to display on the browser, you have to run the `kubectl proxy` command in a separate tab on the terminal. 
- This can be included as a part of the deployscript however, I found running this step manually to be more convenient since it can be started and stopped as the user desires





