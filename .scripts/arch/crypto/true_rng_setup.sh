#!/bin/bash

###########################################
# File: dotfiles/.scripts/arch/crypto/true_rng_setup.sh
# Script Group: Cryptography
# Platform: Arch
# Purpose: To setup the hardware TrueRNG generator as a replacement for /dev/random
# TrueRNG is ridiculously fast
# Using SSH_USE_STRONG_RNG=1024 env variable, 8192bit host key takes less than 30s to generate still.
###########################################

## this is meant to be callable elsewhere. still not 100% set on the installation directory structure
source $HOME/.scripts/bash_params

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo -e "${RED}ERROR:${NC} Please re-run as ${YELLOW}Root${NC} or with ${YELLOW}Sudo${NC}!";
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

pacman -S rng-tools

echo "RNGD_OPTS=\"-o /dev/random -r /dev/TrueRNG\"" > /etc/conf.d/rngd

echo -e "Starting the ${GREEN}RNGd${NC} daemon (but ${RED}not${NC} enabling)"
systemctl start rngd

export "RNGD_OPTS=\"-o /dev/random -r /dev/TrueRNG\""

export "SSH_USE_STRONG_RNG=1024"
