#!/bin/bash

###########################################
# File: dotfiles/.scripts/arch/crypto/true_rng_setup.sh
# Script Group: Cryptography
# Platform: Arch
# Purpose: To setup the hardware TrueRNG generator as a replacement for /dev/random
# TrueRNG is ridiculously fast
# Using SSH_USE_STRONG_RNG=1024 env variable, 8192bit host key takes less than 30s to generate still.
###########################################

RED='\033[1;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [[ $(id -u) -ne 0 ]] ; then
	echo -e "Please re-run as ${RED}Root${NC} or with ${RED}Sudo!${NC}";
	exit 1;
fi


cat <<'EOF' > /etc/udev/rules.d/99-TrueRNG.rules 
# ubld.it TrueRNG
#
# This rule creates a symlin to newly attached CDC-ACM device 
# Also includes fix for wrong termios settings on some linux kernels
# New! includes ignore for modemmanger
# (Thanks neoaeon)
SUBSYSTEM=="tty", ATTRS{product}=="TrueRNG", SYMLINK+="TrueRNG", RUN+="/bin/stty raw -echo -ixoff -F /dev/%k speed 3000000" ATTRS{idVendor}=="04d8", ATTRS{idProduct}=="f5fe", ENV{ID_MM_DEVICE_IGNORE}="1"
EOF

#DEVICE=$1

#if [[ ($DEVICE == "") ]] ; then
#	echo -e "No device specified.";
#	echo -e "Usage: true_rng_setup.sh /dev/ttyXY";
#	echo -e "${GREEN}HINT:${NC} In all liklihood, the TrueRNG is /dev/ttyACM0";
#	exit 1;
#fi

pacman -S rng-tools

echo "RNGD_OPTS=\"-o /dev/random -r /dev/TrueRNG\"" > /etc/conf.d/rngd

echo -e "Starting the ${GREEN}RNGd${NC} daemon (but ${RED}not${NC} enabling)"
systemctl start rngd

export "RNGD_OPTS=\"-o /dev/random -r /dev/TrueRNG\""

export "SSH_USE_STRONG_RNG=1024"
