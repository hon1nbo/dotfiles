#!/bin/bash

##############################################################
# File: dotfiles/.scripts/arch/install/network-diagnostics.sh
# Script Group: Installer
# Platform: Arch
# Purpose: To install common network diagnostic tools
##############################################################

source ../../.bootstrap/common/bash_params

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo -e "${RED}ERROR:${NC} Please re-run as ${YELLOW}Root${NC} or with ${YELLOW}Sudo${NC}!";
        exit 1;
fi


pacman -Sy bind-tools dnsutils traceroute nmap tcpdump speedtest-cli
