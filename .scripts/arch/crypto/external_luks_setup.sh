#!/bin/bash

######################################
# File: dotfiles/.scripts/arch/crypto/external_luks_setup.sh
# Script Group: Cryptography
# Platform: Arch
# Purpose: To setup external media encryption such as LUKS
######################################

source ../../.bootstrap/common/bash_params

if [[ $(id -u) -ne 0 ]] ; then
	echo -e "${RED}ERROR:${NC} Please re-run as ${YELLOW}Root${NC} or with ${YELLOW}Sudo!${NC}";
	echo -e "If your user has block device access without sudo, this has not been checked yet and you can comment out this portion of the script";
	exit 1;
fi

DEVICE=$1

if [[ ($DEVICE == "") ]] ; then
	echo -e "${RED}No device specified.${NC}";
	echo -e "Usage: external_luks_setup.sh /dev/sdXY";
	exit 1;
fi

MODE=aes-xts-plain64
KEY_SIZE=256
HASH=sha256
PBKDF_ITER=4000
FS=ext4

echo -e "Script to encrypt ${CYAN}$DEVICE${NC}"
echo -e "${YELLOW}WARNING:${NC} Default is to use /dev/random"
echo -e "This can block for a LONG time."
echo -e "If not using a hardware Cryptographic RNG, switch to /dev/urandom if feasible"

pause 1

echo -e "Ensuring all the required packages are up to date"
pacman -S exfat-utils xfsprogs parted dm-crypt

cryptsetup -v --cipher $MODE --key-size $KEY_SIZE --hash $HASH --iter-time $PBKDF_ITER --use-random --verify-passphrase luksFormat $DEVICE

echo -e "${GREEN}LUKS Device Created!${NC}"
echo -e "Let's get it formatted and usable!"

cryptsetup luksOpen $DEVICE encrypted-external-drive

if [[ ($FS == "ext4") ]] ; then
	mkfs.ext4 /dev/mapper/encrypted-external-drive;
fi
if [[ ($FS == "ext2") ]] ; then
        mke2fs /dev/mapper/encrypted-external-drive;
fi
if [[ ($FS == "exfat") ]] ; then
        mkfs.exfat /dev/mapper/encrypted-external-drive;
fi
if [[ ($FS == "xfs") ]] ; then
        mkfs.exfat /dev/mapper/encrypted-external-drive;
fi

