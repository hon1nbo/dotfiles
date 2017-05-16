#!/bin/bash

####################################
# Hon1nbo's new system Bootstrapper
# Platform: Multi (Arch, Debian, Centos/RHEL)
# The goal of this script is to bootstrap various items in the system that are of critical importance to have a working platform
# 
# This includes moving in profiles, setting up critical trust, etc.
####################################

# Check if we have privs to install

if [[ $(id -u) -ne 0 ]] ; then
        echo "Please re-run as Root or with Sudo!";
        exit 1;
fi

# Leave as-is unless you want to set an absolute path manually.
BOOTSTRAP_DIR=$PWD
SCRIPTS_DIR=$PWD/../

#################################
# Make sure to edit your configs!

source $BOOTSTRAP_DIR/config
#################################

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

########################
# Core Package Installs

bash $SCRIPTS_DIR/$PLATFORM/install/cli-basic.sh

if [[ $DESKTOP -ne "none" ]] ; then
	bash $SCRIPTS_DIR/$PLATFORM/install/xorg.sh;
        bash $SCRIPTS_DIR/$PLATFORM/install/$DESKTOP.sh;
	bash $SCRIPTS_DIR/$PLATFORM/install/desktop-common.sh;
        mkdir -p /home/$NEWUSER/.scripts/$DESKTOP;
        rsync -av $SCRIPTS_DIR/$PLATFORM/$DESKTOP/ /home/$NEWUSER/.scripts/$DESKTOP/;
        ln -s /home/$NEWUSER/.scripts/$DESKTOP/xinitrc /home/$NEWUSER/.xinitrc;
fi
#######################

# let's go ahead and put the scripts in this user's homedir

rsync -av $BOOTSTRAP_DIR/common/home/ /home/$NEWUSER/
rsync -av $SCRIPTS_DIR/$ARCH/home/ /home/$NEWUSER/

# fix permissions on the SSH folder
chmod 700 /home/$NEWUSER/.ssh
chmod 640 /home/$NEWUSER/.ssh/*

# fix general home folder ownership
chown -R $NEWUSER:$NEWUSER /home/$NEWUSER

###########################
# Install Optional Package Choices

if [[ $NET_DIAG == "true" ]] ; then
        bash $SCRIPTS_DIR/$PLATFORM/install/network-diagnostics.sh;
fi
if [[ $VIRTUALIZATION == "true" ]] ; then
        bash $SCRIPTS_DIR/$PLATFORM/install/virtualization.sh;
fi

##########################
