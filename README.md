# zservers
Infrastructure definitions for silly projects that Zach does :) 

ansible-playbook mgmt/ansible/playbooks/init.yml --inventory

ansible-playbook mgmt/ansible/playbooks/init.yml -i mgmt/ansible/inventories/core.yml -K \
--extra-vars "core_ip=test \ 
              ansible_ssh_pass=test \ 
              zserver_git_username=name \ 
              zserver_git_pw=pw"