#!/bin/bash

## This is to setup basic desktop requirements (including CLI if not already present) with an i3 window manager

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo "Please re-run as Root or with Sudo!";
        exit 1;
fi


pacman -S xorg xorg-server-common xorg-xinit
