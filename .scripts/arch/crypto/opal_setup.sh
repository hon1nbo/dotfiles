#!/bin/bash

##################################
# File: dotfiles/.scripts/arch/crypto/opal_setup.sh
# Script Group: Cryptography
# Platform: Arch
# Purpose: To setup OPAL support for an SED
##################################


if [[ $(id -u) -ne 0 ]] ; then
	echo "Please re-run as Root or with Sudo!";
	exit 1;
fi

## setup SED util
yaourt -S sedutil

###########
# TODO: script ensuring the libata.tmp=1 flag is set in kernel parameters
###########
