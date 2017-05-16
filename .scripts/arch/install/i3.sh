#!/bin/bash

## This is to setup basic desktop requirements (including CLI if not already present) with an i3 window manager

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo "Please re-run as Root or with Sudo!";
        exit 1;
fi

sh $PWD/install_basic_cli.sh

pacman -Sy i3 dmenu imagemagick i3lock scrot xautolock keepass chromium termite xterm firefox

