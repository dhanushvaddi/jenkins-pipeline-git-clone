🎯 Scenario

Your organization is aiming at automating the infrastructure creation and the deployment procedure. You are tasked with setting up and configuring the AWS environment to meet specific requirements.

Question:

Launch an EC2 instance manually and install Terraform on it.

Use Terraform to create 3 EC2 instances (in default VPC and subnets only).

Use a user_data shell script (external file) to install Ansible on the first instance.

Configure passwordless SSH access between the Ansible master and the other two slave instances.

Set up the Ansible inventory file /etc/ansible/hosts with the IPs of the slave machines.

Create and run an Ansible playbook:

Install Java and Jenkins on the Jenkins slave.

Install Java only on the Java slave.

Setup Jenkins and its dashboard on the Jenkins slave.

Add the other slave as a Jenkins agent/node.

Create a Jenkins Pipeline Job (not freestyle) that pulls the following GitHub repository into the Jenkins slave:

https://github.com/dhanushvaddi/jenkins-pipeline-git-clone

📝 Note: Each task must be verified with proper screenshots during submission. Execution results alone do not count if the configuration/setup process is not shown.
