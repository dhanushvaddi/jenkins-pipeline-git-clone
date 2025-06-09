## README.md

# Jenkins Pipeline GitHub Clone on Slave Node

## 📊 Overview

This project automates the cloning of a GitHub repository using a Jenkins Pipeline job on a Jenkins slave (agent) node.

The setup includes:

* Infrastructure provisioning with **Terraform**
* Configuration management with **Ansible**
* Continuous Integration using **Jenkins Pipeline**

## 💼 Stack

* AWS EC2
* Terraform
* Ansible
* Jenkins
* GitHub

## 🚀 Goal

Use Jenkins Pipeline (not Freestyle) to clone the following GitHub repository on a Jenkins slave node:

```
https://github.com/dhanushvaddi/jenkins-pipeline-git-clone
```

---

## 🛠️ Terraform Setup (`main.tf`)

```hcl
provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_instance" "ansible_master" {
  ami           = "ami-0a605bc2ef5707a18"
  instance_type = "t2.micro"
  key_name      = "Oregon"
  subnet_id     = element(data.aws_subnets.default.ids, 0)
  associate_public_ip_address = true
  user_data     = file("user_data.sh")

  tags = {
    Name = "Ansible-Master"
  }
}

resource "aws_instance" "jenkins_slave" {
  ami           = "ami-0a605bc2ef5707a18"
  instance_type = "t2.micro"
  key_name      = "Oregon"
  subnet_id     = element(data.aws_subnets.default.ids, 1)
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins-Slave"
  }
}

resource "aws_instance" "java_slave" {
  ami           = "ami-0a605bc2ef5707a18"
  instance_type = "t2.micro"
  key_name      = "Oregon"
  subnet_id     = element(data.aws_subnets.default.ids, 2)
  associate_public_ip_address = true

  tags = {
    Name = "Java-Slave"
  }
}

output "instance_ips" {
  value = {
    ansible_master = aws_instance.ansible_master.public_ip
    jenkins_slave  = aws_instance.jenkins_slave.public_ip
    java_slave     = aws_instance.java_slave.public_ip
  }
}
```

---

## 🔧 user\_data.sh (Ansible Master Setup)

```bash
#!/bin/bash
apt-get update -y
apt-get install -y software-properties-common curl git sshpass
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible
ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -N ""
```

---

## 📃 Ansible Inventory (`/etc/ansible/hosts`)

```ini
[jenkins-slave]
<jenkins_slave_ip>

[java-slave]
<java_slave_ip>
```

---

## 📄 play.yaml

```yaml
---
- name: Install Java and Jenkins on Jenkins-Slave
  hosts: jenkins-slave
  become: true
  tasks:
    - name: Execute Jenkins installation script
      script: 1.sh

- name: Install Java on Java-Slave
  hosts: java-slave
  become: true
  tasks:
    - name: Execute Java installation script
      script: 2.sh
```

---

## 🔢 1.sh

```bash
#!/bin/bash

sudo apt update
sudo apt install openjdk-17-jdk -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y
```

---

## 🔢 2.sh

```bash
#!/bin/bash

sudo apt update
sudo apt install openjdk-17-jdk -y
```

---

## 📅 Jenkins Pipeline Script

```groovy
pipeline {
    agent {
        label 'node1'
    }

    stages {
        stage('Clone GitHub Repo') {
            steps {
                git url: 'https://github.com/dhanushvaddi/jenkins-pipeline-git-clone', branch: 'main'
                sh 'ls -l'
            }
        }
    }

    post {
        success {
            echo 'Repository cloned successfully on Node1.'
        }
        failure {
            echo 'Failed to clone repository.'
        }
    }
}
```

---

## 🚀 Final Output

* GitHub repo successfully cloned onto Jenkins slave node
* Verified via `ls -l` in Jenkins console log
* Fully automated using Terraform ➟ Ansible ➟ Jenkins Pipeline

---

## 🔗 GitHub Repo to Clone

[https://github.com/dhanushvaddi/jenkins-pipeline-git-clone](https://github.com/dhanushvaddi/jenkins-pipeline-git-clone)

---

## 👨‍💻 Author

Project created for hands-on DevOps automation using real-world CI tools.

---
