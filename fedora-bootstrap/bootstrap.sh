#!/bin/bash

# set strict error handling
set -euo pipefail


# --- Environment Checks ---
[ "$(id -u)" -eq 0 ] || { echo "Run with sudo!" >&2; exit 1; }
grep -q "Fedora" /etc/os-release || { echo "Only Fedora supported!"; exit 1; }


# Source Utils
source_utils() {
    for CONFIG in ./utils/*.sh; do
        echo "[+] sourcing $CONFIG"
        source "$CONFIG"
    done
}


main(){
    # Source Utils
    source_utils
    stopwatch_start

    # Source Main Settings
    source_settings

    # Source Specifically declared configurations
    source_selected_configs

    # Source config.d scripts
    source_config_directory

    # Packages
    install_packages
    remove_packages

    # Clean Up
    stopwatch_end
}


main "$@"
