# Usage
- make a copy of the `all.yml.sample` into `all.yml` (and any other role you might want)
  - a quick starting point is by looking for `REPLACE_THIS_`
- adapt as needed
- run the playbook

# ToDo
Tip: Search for `[:TODO:]` or `[:FIX:]` for quicker tasks

## Alpha
1. Configure HTPC: Kodi
2. Configure HTPC: RetroArch

## MVP Stage
1. Add External Software to "personal" playbook (vscodium, brave)
2. Change Power Settings (increase time until Power Saver)
3. ~~Fix gnome tweak not being applied to the user correctly~~


# Adapting the Playbook for yourself

## Select Specific Roles
- htpc
  - used for HTPC setup 
  
- workstation
  
- vps

### Variables used
[:TODO:] Document Variables Used (roles: common, htpc, workstation)

- apt_cache_valid_time

- update_packages

- upgrade_packages

- install_security_updates

- flatpak_packages_workstation_present

- software_packages_common_present

- software_packages_htpc_present

- software_packages_workstation_present


## Used Tags
[:TODO:] Expand and Document Tags