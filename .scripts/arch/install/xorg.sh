#!/bin/bash

###############################################
# File: dotfiles/.scripts/arch/install/xorg.sh
# Script Group: Installer
# Platform: Arch
# Purpose: To install the X.org server
###############################################


# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo "Please re-run as Root or with Sudo!";
        exit 1;
fi


pacman -S xorg xorg-server-common xorg-xinit
