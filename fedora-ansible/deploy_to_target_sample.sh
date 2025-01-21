#!/bin/bash

# -i    -   inventory file
# -K    -   ask for become password
ansible-playbook -i playbooks/inventory_targets.yml playbooks/htpc_playbook.yml --vault-password=playbooks/secrets/htpc_pwd.txt -K
