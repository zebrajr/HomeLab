# Usage
- make a copy of the `all.yml.sample` into `all.yml` (and any other role you might want)
- adapt as needed
  - a quick starting point is by looking for `REPLACE_THIS_` and which packages you (don't) want 
- run the playbook
  - check `10_scripts` for a bootstrap script on using them

***

# ToDo
Tip: Search for `[:TODO:]` or `[:FIX:]` for quicker tasks

- Add "vps" role to ansible playbooks 


***

# Files and Directories
**10_scripts/** : bash scripts to help bootstrap or helping reminding how to run the playbooks

**group_vars/**: This directory is variables that will be applied on every system are present

**roles/** : where the roles are defined. Each system has the "common" role and then one or more extra roles applied to it

**ansible.cfg**: Configuration settings for Ansible goes here.

**inventory**: This is the inventory file.

**playbook**: The main playbook to be used when running it against a system


***

# Adapting the Playbook for yourself

## Select Specific Roles
- htpc : used for HTPC setups, has autologin, remote control support, etc
- personalstation : steam, music, photo editing, etc
- workstation : development work, including VMs via KVM / QEMU, docker, vscodium, etc
- ~~vps : not yet implemented~~ 
- make your own :)
  

## Variables used for roles

### all
| Variable                         | Description                                                           | Default |
| -------------------------------- | --------------------------------------------------------------------- | ------- |
| apt_cache_valid_time             | Sets how long is the cache valid for the apt updates                  | 3600    |
| update_packages                  | Sets if the packages should be checked for new versions               | true    |
| upgrade_packages                 | Sets if the packages should be upgraded if a new version is available | true    |
| install_security_updates         | Sets if security updates should be installed                          | true    |
| common_users                     |                                                                       |         |
| flatpak_common_remotes           | Array describing which flatpak remote url should be configured        |         |
| software_packages_common_present | Sets which apt packages should be present / installed on the system   |         |
| software_pip_common_present      | Sets which pip packages should be present / installed on the system   |         |

### htpc
| Variable                       | Description                                                                                       | Default   |
| ------------------------------ | ------------------------------------------------------------------------------------------------- | --------- |
| software_packages_htpc_present | Which apt packages should be present                                                              |           |
| flatpak_packages_htpc_present  | Which flatpaks should be present on the system                                                    |           |
| htpc_main_user                 | the main user for the HTPC sytem. Auto login, auto start and other settings will be applied to it | htpc_user |
| htpc_main_user_password        | the main user password for the system                                                             |           |
| htpc_shared_directories        | which directories should be created (and shared) for the htpc system users                        |           |
| htpc_groups_present            | which groups should be present                                                                    | htpc      |
| htpc_users_present             | which users should be present in each group                                                       |           |


### workstation
| Variable                              | Description                                                                                   | Default |
| ------------------------------------- | --------------------------------------------------------------------------------------------- | ------- |
| software_packages_workstation_present | which packages should be present on the system                                                |         |
| flatpak_packages_workstation_present  | which flatpaks should be present on the system                                                |         |
| install_XXXXX                         | If the package should be installed. Used in software that comes from third party repositories |         |


### personalstation
| Variable                       | Description                                                                                       | Default |
| Variable                              | Description                                    | Default |
| ------------------------------------- | ---------------------------------------------- | ------- |
| software_packages_personalstation_present | which packages should be present on the system |         |
| flapatk_packages_personalstation_present  | which flatpaks should be present on the system |         |



## Used Tags
[:TODO:] Expand and Document Tags


