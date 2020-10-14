#!/bin/bash

###############################################
# File: dotfiles/.scripts/arch/install/xorg.sh
# Script Group: Installer
# Platform: Arch
# Purpose: To install the X.org server
###############################################

## this is meant to be called as a bootstrapper, so may not be in the usual place
SCRIPTS_DIR=$1
source $SCRIPTS_DIR/bash_params

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo "Please re-run as Root or with Sudo!";
        exit 1;
fi


pacman -S xorg xorg-server-common xorg-xinit xorg-xrandr
