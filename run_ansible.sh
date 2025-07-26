#!/bin/bash

# Variables
ssh_user="root"
ssh_password="password"  # Default password set in worker nodes

# Create the Ansible inventory file
echo "[worker_nodes]" > hosts
echo "This script is for managing worker nodes with Ansible"

# Dynamically add worker nodes passed as arguments
workernodes=("worker-node1" "worker-node2")
for i in "${workernodes[@]}"; do
    echo "Adding worker node: $i"
    echo "$i ansible_user=$ssh_user ansible_password=$ssh_password ansible_connection=ssh" >> hosts
done

echo "Generated Ansible inventory file:"
cat hosts

# Run the Ansible playbook
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts playbook.yml -vvv

