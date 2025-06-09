provider "aws" {
  region = "us-east-1"
  access_key = "" #get key from IAM user
  secret_key = "" #get key from IAM user
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
  key_name      = "Your-Key-Pair" #Add your key pair
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
  key_name      = "Your-Key-Pair" #Add your key pair
  subnet_id     = element(data.aws_subnets.default.ids, 1)
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins-Slave"
  }
}

resource "aws_instance" "java_slave" {
  ami           = "ami-0a605bc2ef5707a18"
  instance_type = "t2.micro"
  key_name      = "Your-Key-Pair" #Add your key pair
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
