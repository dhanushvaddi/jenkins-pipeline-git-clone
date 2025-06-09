
# Cloning GitHub Repos with Jenkins Pipeline on a Slave Node

## 📘 Project Overview

This project demonstrates a complete DevOps flow using:
- AWS EC2 infrastructure provisioned via Terraform
- Ansible for configuration management
- Jenkins Pipeline to automate cloning a GitHub repository to a remote Jenkins agent (slave node)

---

## 🏗️ Infrastructure Setup (Terraform)

- **Three Ubuntu EC2 Instances Created:**
  - Ansible Master
  - Jenkins Slave
  - Java Slave

- **Terraform Highlights:**
  - Used `data.aws_vpc` and `data.aws_subnets` to reference default VPC and subnets
  - `user_data.sh` used to automatically install Ansible on Ansible Master

```hcl
output "instance_ips" {
  value = {
    ansible_master = aws_instance.ansible_master.public_ip
    jenkins_slave  = aws_instance.jenkins_slave.public_ip
    java_slave     = aws_instance.java_slave.public_ip
  }
}
