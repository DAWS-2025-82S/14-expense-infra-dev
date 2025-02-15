#!/bin/bash

dnf install ansible -y
# push
# ansible-playbook -i inventory mysql.yaml

#pull
ansible-pull  -i localhost, -U https://github.com/DAWS-2025-82S/15-expense-roles-terraform.git main.yaml -e COMPONENT=backend -e ENVIRONMENT=$1