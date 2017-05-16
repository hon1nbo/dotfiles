#!/bin/bash

## This is to setup basic CLI Requirements.

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo "Please re-run as Root or with Sudo!";
        exit 1;
fi

# TODO: work-in and msdosutils for formatting fat partitions. May need additional repo, or I have wrong package listed

echo "Let's update things first"
pacman -Syyu

echo "Now let's install some of the packages we need"
pacman -S rsync dialog screen nano vim zsh p7zip parted unzip openssh git
