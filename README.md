# zservers
Infrastructure definitions for silly projects that Zach does :) 

ansible-playbook mgmt/ansible/playbooks/init.yaml --inventory

ansible-playbook mgmt/ansible/playbooks/init.yaml -i mgmt/ansible/inventories/core.yml --extra-vars "core_ip=test ansible_ssh_pass=test" -K