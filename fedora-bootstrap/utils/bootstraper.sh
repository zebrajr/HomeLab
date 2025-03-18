#!/bin/bash

# Getting the main settings.conf file
source_settings(){
    echo "[+] sourcing settings.conf"
    source settings.conf
}

# Sources entire config.d directory 
source_config_directory() {
    for CONFIG in ./config.d/*.conf; do
        echo "[+] Sourcing $CONFIG"
        source "$CONFIG"
    done
}

# Install everything that was added to PACKAGES_TO_INSTALL
install_packages() {
    INSTALL_OPTIONS=""

    # Check if VERBOSE_MODE is off
    if ! $VERBOSE_MODE; then
        INSTALL_OPTIONS+=" > /dev/null"
    fi

    for TARGET_PACKAGE in "${PACKAGES_TO_INSTALL[@]}"; do
        echo "[.] Installing $TARGET_PACKAGE"
        eval "sudo $PKG_MGR install $TARGET_PACKAGE -y $INSTALL_OPTIONS 2>&1"
    done
}

remove_packages() {
    INSTALL_OPTIONS=""

    # Check if VERBOSE_MODE is off
    if ! $VERBOSE_MODE; then
        INSTALL_OPTIONS+=" > /dev/null"
    fi

    for TARGET_PACKAGE in "${PACKAGES_TO_REMOVE[@]}"; do
        echo "[.] Removing $TARGET_PACKAGE"
        eval "sudo $PKG_MGR remove $TARGET_PACKAGE -y $INSTALL_OPTIONS 2>&1"
    done
}

source_target_directory() {
    local TARGET_DIRECTORY="$1"
    SOURCE_PATH="./${TARGET_DIRECTORY}/*.conf"
    for CONFIG in $SOURCE_PATH; do
        echo "[+] Sourcing $CONFIG"
        source "$CONFIG"
    done
}

# Sources files declared in SOURCE_CONFIG_FILE
source_selected_configs() {
    for CONFIG in "${SOURCE_CONFIG_FILE[@]}"; do
        SOURCE_PATH="./${CONFIG}.conf"
        echo "[+] Sourcing $SOURCE_PATH"
        source "$SOURCE_PATH"
    done
}

# Prevent the script from executing when sourced
return 0 2>/dev/null
exit 0
