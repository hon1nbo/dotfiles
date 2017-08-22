#!/bin/bash

##################################
# File: dotfiles/.scripts/arch/crypto/opal_setup.sh
# Script Group: Cryptography
# Platform: Arch
# Purpose: To setup OPAL support for an SED
##################################


SCRIPTS_DIR=$1
source $SCRIPTS_DIR/bash_params

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo -e "${RED}ERROR:${NC} Please re-run as ${YELLOW}Root${NC} or with ${YELLOW}Sudo${NC}!";
        exit 1;
fi

## setup SED util
yaourt -S sedutil-cli

###########
# TODO: script ensuring the libata.tmp=1 flag is set in kernel parameters
###########
