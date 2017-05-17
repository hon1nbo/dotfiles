#!/bin/bash

###################################################################
# File: dotfiles/.scripts/arch/install/cli-basic.sh
# Script Group: Installer
# Platform: Arch
# Purpose: To setup the common CLI commands required on all systems
###################################################################

source ../../.bootstrap/common/bash_params

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo -e "${RED}ERROR:${NC} Please re-run as ${YELLOW}Root${NC} or with ${YELLOW}Sudo${NC}!";
        exit 1;
fi

# TODO: work-in and msdosutils for formatting fat partitions. May need additional repo, or I have wrong package listed

echo "Let's update things first"
pacman -Syyu

echo "Now let's install some of the packages we need"
pacman -S rsync dialog wpa_actiond ifplugd wpa_suppicant sudo screen nano vim zsh p7zip parted unzip openssh git
