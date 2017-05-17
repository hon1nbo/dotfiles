#!/bin/bash

#########################################################
# File: dotfiles/.scripts/arch/install/desktop-common.sh
# Script Group: Installer
# Platform: Arch
# Purpose: To setup common Desktop apps
#########################################################

source ../../.bootstrap/common/bash_params

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo -e "${RED}ERROR:${NC} Please re-run as ${YELLOW}Root${NC} or with ${YELLOW}Sudo${NC}!";
        exit 1;
fi


pacman -S i3 keepass chromium termite xterm firefox redshift xrandr pulseaudio pulseaudio-alsa pamixer
