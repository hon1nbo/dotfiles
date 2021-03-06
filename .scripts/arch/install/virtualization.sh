#!/bin/bash

############################################################
# File: dotfiles/.scripts/arch/install/virtualization.sh
# Script Group: Installer
# Platform: Arch
# Purpose: To setup the requirements for a local Hypervisor
############################################################

## this is meant to be called as a bootstrapper, so may not be in the usual place
SCRIPTS_DIR=$1
source $SCRIPTS_DIR/bash_params

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo -e "${RED}ERROR:${NC} Please re-run as ${YELLOW}Root${NC} or with ${YELLOW}Sudo${NC}!";
        exit 1;
fi

pacman -Sy virt-manager linux-headers virtualbox virtualbox-host-modules-arch virtualbox-guest-iso
