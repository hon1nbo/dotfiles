#!/bin/bash

###################################################
# File: dotfiles/.scripts/arch/install/i3.sh
# Script Group: Installer
# Platform: Arch
# Purpose: To setup external the i3 Window Manager
###################################################

// this is meant to be called as a bootstrapper, so may not be in the usual place
SCRIPTS_DIR=$1
source $SCRIPTS_DIR/bash_params
source $SCRIPTS_DIR/.bootstrap/common/config

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo -e "${RED}ERROR:${NC} Please re-run as ${YELLOW}Root${NC} or with ${YELLOW}Sudo${NC}!";
        exit 1;
fi

pacman -Sy i3 dmenu imagemagick i3lock scrot xautolock compton

echo -e "echo -e "alias lock='~/.scripts/i3/i3_lock.sh'" >> /home/$NEWUSER/.bashrc
