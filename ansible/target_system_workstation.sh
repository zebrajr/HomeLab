#!/bin/bash
ansible-playbook -i inventory playbook.yml -e "target_system=workstation" --ask-become-pass