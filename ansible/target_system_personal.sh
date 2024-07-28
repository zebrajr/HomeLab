#!/bin/bash
ansible-playbook -i inventory playbook.yml -e "target_system=personal" --ask-become-pass