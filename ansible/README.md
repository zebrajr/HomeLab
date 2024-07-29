# Usage
- make a copy of the `all.yml.sample` into `all.yml` (and any other role you might want)
  - a quick starting point is by looking for `REPLACE_THIS_`
- adapt as needed
- run the playbook

# ToDo

1. Add External Software to "personal" playbook (vscodium, brave)
2. Fix gnome tweak not being applied to the user correctly


# Adapting the Playbook for yourself

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