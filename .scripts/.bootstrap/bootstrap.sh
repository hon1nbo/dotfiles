#!/bin/bash

# Platform: Arch Linux

# The goal of this script is to bootstrap various items in the system that are of critical importance.
# This includes moving in profiles, setting up critical trust, etc.

# Check if we have privs to install
if [[ $(id -u) -ne 0 ]] ; then
        echo "Please re-run as Root or with Sudo!";
        exit 1;
fi

# Leave as-is unless you want to set an absolute path manually.
BOOTSTRAP_DIR=$PWD
SCRIPTS_DIR=$PWD/../

###########################################
# Set the following Options #

NEWUSER=changeme
NEW_USER_SUDO=false # set to true if you want them in the Wheel group

# change the desired platform here if not using Arch
PLATFORM=arch

# Set to false if you don't want the i3 Window Manager. Requires basic CLI packages
INSTALL_i3=true

BASIC_CLI_PATH=$SCRIPTS_DIR/$PLATFORM/install/cli-basic.sh
i3_PATH=$SCRIPTS_DIR/$PLATFORM/install/i3.sh

# enable additional package groups at will

VIRTUALIZATION=false
NET_DIAG=false

#TODO: add these scripts
STEAM_GAMES=false
SED_OPAL=false
OFFICE_EDITING_UTILS=false

################################################

# Check if the required items are set
if [[ $NEWUSER == "changeme" ]] ; then
        echo "Please set the new username in the script!";
        exit 1;
fi
if [[ $NEW_USER_SUDO == "unknown" ]] ; then
        echo "Please set the new username's sudo in the script!";
        exit 1;
fi


echo "Adding user $NEWUSER"
useradd -m $NEWUSER

if [[ $NEWUSERSUDO == "true" ]] ; then
        echo "Putting $NEWUSER in the Wheel group";
        usermod -a -G wheel $NEWUSER;
fi

echo "Set the password for $NEWUSER"
passwd $NEWUSER

# let's go ahead and put the scripts in this user's homedir

cp -r $BOOTSTRAP_DIR/common/home/* /home/$NEWUSER/
cp -r $SCRIPTS_DIR/$ARCH/home/* /home/$NEWUSER/

# fix permissions on the SSH folder
chmod 700 /home/$NEWUSER/.ssh
chmod 640 /home/$NEWUSER/.ssh/*

# fix general home folder ownership
chown -R $NEWUSER:$NEWUSER /home/$NEWUSER

########################
# Core Package Installs

bash $BASIC_CLI_PATH

if [[ $INSTALL_i3 == "true" ]] ; then
        bash i3_PATH;
fi
#######################

###########################
# Install Optional Package Choices

if [[ $NET_DIAG == "true" ]] ; then
        bash $SCRIPTS_DIR/$PLATFORM/install/network-diagnostics.sh;
fi
if [[ $VIRTUALIZATION == "true" ]] ; then
        bash $SCRIPTS_DIR/$PLATFORM/install/virtualization.sh;
fi

##########################
