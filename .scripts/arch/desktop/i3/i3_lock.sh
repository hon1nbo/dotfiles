#!/bin/bash

#####################################################
# File: dotfiles/.scripts/arch/desktop/i3/i3_lock.sh
# Script Group: Desktop
# Platform: Arch
# Purpose: To setup create a blurred screen locker
#####################################################


# This makes a blurred lockscreen for i3 windows manager.

source ../../.bootstrap/common/bash_params

if [[ $(id -u) == 0 ]] ; then
	echo -e "${RED}Why are you running as root?!${NC}";
	echo -e "${YELLOW} Kill the root session. This uses ${RED}ImageMagick${NC}";
	exit 1;
fi


IMG=/tmp/lockscreen.png
SCRCAP="scrot $IMG"

# All options are here: http://www.imagemagick.org/Usage/blur/#blur_args
BLURTYPE="0x5"
#BLURTYPE="0x2"
#BLURTYPE="5x2"
#BLURTYPE="2x8"
#BLURTYPE="2x3"

$SCRCAP
convert $IMG -resize 25% $IMG
convert $IMG -blur $BLURTYPE $IMG
convert $IMG -resize 400% $IMG
i3lock -i $IMG
#rm $IMG


