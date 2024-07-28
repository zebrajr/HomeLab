
# ToDo

1. Add External Software to "personal" playbook (vscodium, brave)
2. Fix gnome tweak not being applied to the user correctly


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

- run_htpc_tasks

- run_workstation_tasks

- flatpak_packages_workstation_present

- software_packages_common_present

- software_packages_htpc_present

- software_packages_workstation_present


## Used Tags
- all
  - all tasks

- common
  - changes that are done across all systems (apt update, upgrade, common software, etc).

- security
  - tasks related to system security only

- software
  - tasks related to software installation and removal