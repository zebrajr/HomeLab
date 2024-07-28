#!/bin/bash
ansible-playbook -i inventory playbook.yml -e "target_system=htpc" --ask-become-pass