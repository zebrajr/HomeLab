#!/bin/bash

# Prompt the user for the become username and password
read -p "Enter the become username: " become_username
read -s -p "Enter the become password: " become_password
echo

# Create the variables file
mkdir -p ../encrypted_vars
cat <<EOF > ../encrypted_vars/encrypted_vars.yml
become_username: ${become_username}
become_password: ${become_password}
EOF

# Prompt the user for the vault password
echo
echo "Enter the vault password to encrypt the variables file:"
ansible-vault encrypt ../encrypted_vars/encrypted_vars.yml

# Save the vault password to a file
read -s -p "Enter the vault password again to save it to a file: " vault_password
echo
echo "${vault_password}" > ../encrypted_vars/vault_password.txt

# Set the permissions of the vault password file
chmod 600 ../encrypted_vars/vault_password.txt

echo "The encrypted_vars.yml has been created and encrypted."
echo "The vault password file has been saved to ../encrypted_vars/vault_password.txt with restricted permissions."
