#!/bin/bash
apt-get update -y
apt-get install -y software-properties-common curl git sshpass
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible
ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -N ""
