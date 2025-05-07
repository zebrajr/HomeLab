#!/bin/bash
if [ "$SETUP_WORKSTATION" != "true" ]; then
    echo "${SKIPPING_PRE_TEXT} qemu-kvm. SETUP_WORKSTATION is not true"
    return 0
fi

echo "${INSTALLING_PRE_TEXT} qemu-kvm virt-manager bridge-utils libvirt"
eval "sudo dnf install qemu-kvm virt-manager libvirt bridge-utils -y $OUTPUT_CONTROL"
