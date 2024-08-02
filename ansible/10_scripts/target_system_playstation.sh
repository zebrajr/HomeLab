#!/bin/bash
# Asks you for the user password
#ansible-playbook -i ../inventory ../playbook.yml -e "target_system=playstation" --ask-become-pass

# Runs from the encrypted variables
ansible-playbook -i ../inventory ../playbook.yml -e "target_system=playstation" --vault-password-file ../encrypted_vars/vault_password.txt