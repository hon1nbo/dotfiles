#!/bin/bash

## This is to setup basic CLI Requirements.

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo "Please re-run as Root or with Sudo!";
        exit 1;
fi

pacman -Sy dialog screen nano vim zsh p7zip parted msdostools unzip gunzip openssh git


