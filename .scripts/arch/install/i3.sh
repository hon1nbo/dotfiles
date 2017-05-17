#!/bin/bash

###################################################
# File: dotfiles/.scripts/arch/install/i3.sh
# Script Group: Installer
# Platform: Arch
# Purpose: To setup external the i3 Window Manager
###################################################

source ../../.bootstrap/common/bash_params

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo -e "${RED}ERROR:${NC} Please re-run as ${YELLOW}Root${NC} or with ${YELLOW}Sudo${NC}!";
        exit 1;
fi

pacman -S i3 dmenu imagemagick i3lock scrot xautolock compton
