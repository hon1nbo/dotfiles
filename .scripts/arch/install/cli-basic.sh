#!/bin/bash

###################################################################
# File: dotfiles/.scripts/arch/install/cli-basic.sh
# Script Group: Installer
# Platform: Arch
# Purpose: To setup the common CLI commands required on all systems
###################################################################


// this is meant to be called as a bootstrapper, so may not be in the usual place
SCRIPTS_DIR=$1
source $SCRIPTS_DIR/bash_params


# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo -e "${RED}ERROR:${NC} Please re-run as ${YELLOW}Root${NC} or with ${YELLOW}Sudo${NC}!";
        exit 1;
fi

# TODO: work-in and msdosutils for formatting fat partitions. May need additional repo, or I have wrong package listed

echo "Let's update things first"
pacman -Syyu

echo "Now let's install some of the packages we need"
pacman -S rsync dialog wpa_actiond ifplugd wpa-supplicant sudo screen nano vim zsh p7zip parted unzip openssh git

// let's build package-query & yaourt
git clone https://aur.archlinux.org/package-query
cd package-query && makepkg -syri && cd ../
git clone https://aur.archlinux.org/yaourt
cd yaourt && makepkg -syri && cd ../

