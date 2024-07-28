
# ToDo

1. Add External Software to "personal" playbook (vscodium, brave)


# Using the Playbook

## Used Vars

- all
  - common to ALL systems
  
- htpc
  - used for the HTPC 
  
- workstation
  
- vps

### Variables used
- apt_cache_valid_time

- update_packages

- upgrade_packages

- install_security_updates

- software_packages_present

- flatpak_packages

## Used Tags
- all
  - all tasks

- common
  - changes that are done across all systems (apt update, upgrade, common software, etc).

- security
  - tasks related to system security only

- software
  - tasks related to software installation and removal