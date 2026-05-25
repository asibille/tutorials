# Inventaire Ansible - Genere par Terraform
# NE PAS EDITER MANUELLEMENT

[linux_nodes]
ubuntu-node   ansible_host=${ubuntu_ip}
fedora-node   ansible_host=${fedora_ip}
redhat-node   ansible_host=${redhat_ip}

[linux_nodes:vars]
ansible_user=${ansible_user}
ansible_ssh_private_key_file=${ansible_ssh_private_key}
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
ansible_python_interpreter=/usr/bin/python3

[controller]
localhost ansible_connection=local

[all:vars]
ansible_user=${ansible_user}
