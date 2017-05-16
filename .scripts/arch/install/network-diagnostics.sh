#!/bin/bash

## This is to setup basic network diagnostic tools

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo "Please re-run as Root or with Sudo!";
        exit 1;
fi

pacman -Sy bind-tools dnsutils traceroute nmap tcpdump