#!/bin/bash

if [[ $(id -u) -ne 0 ]] ; then
	echo "Please re-run as Root or with Sudo!";
	exit 1;
fi

## setup SED util
yaourt -S sedutil
