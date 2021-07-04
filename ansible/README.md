# Ansible
Playbooks and ansible configs to deploy different systems

### Situation


### Task
- Make a copy of .env-sample
```
cp .env-sample .env
```
- Edit with your own values
- Change the IPs under <fileName>Hosts.yml
- Run the playbook
```
ansible-playbook -i <fileName>Hosts.yml <fileName>Playbook.yml
```

### Result


### Note

### ToDo
- Configure .env-fireflyiii
- Add Ansible deployment basics
- Change to single config.sh
- Add limit to backup files
- Automatic Backup from used Images
