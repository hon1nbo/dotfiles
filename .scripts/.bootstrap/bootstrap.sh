#!/bin/bash

############################################################################
# Hon1nbo's new system Bootstrapper
# File: dotfiles/.scripts/.bootstrap/bootstrap.sh
# Platform: Multi (Arch, Debian, Centos/RHEL)
# Purpose: The goal of this script is to bootstrap various items
# in the system that are of critical importance to have a working platform
# This includes moving in profiles, setting up critical trust, etc.
############################################################################

# Leave as-is unless you want to set an absolute path manually.
BOOTSTRAP_DIR=$PWD
SCRIPTS_DIR=$PWD/../

#################################
# Make sure to edit your config!

source $BOOTSTRAP_DIR/common/config
#################################

source $BOOTSTRAP_DIR/common/bash_params

if [[ $(id -u) -ne 0 ]] ; then
        echo -e "${RED}ERROR:${NC} Please re-run as ${YELLOW}Root${NC} or with ${YELLOW}Sudo!${NC}";
        exit 1;
fi

# Let's run a quick Update 
# & install the required base packages

bash $SCRIPTS_DIR/$PLATFORM/install/cli-basic.sh
##################################
# Check if the required items are set
if [[ $NEWUSER == "changeme" ]] ; then
        echo -e "${RED}ERROR:${NC} Please set the new ${YELLOW}username${NC} in the script!";
        exit 1;
fi
if [[ $NEW_USER_SUDO == "unknown" ]] ; then
        echo -e "${RED}ERROR:${NC}Please set the new username's ${YELLOW}sudo rights${NC} in the script!";
        exit 1;
fi


echo "Adding user $NEWUSER"
useradd -m -s $NEW_USER_SHELL $NEWUSER

if [[ $NEWUSERSUDO == "true" ]] ; then
        echo "Putting $NEWUSER in the Wheel group";
        usermod -a -G wheel $NEWUSER;
fi

echo -e "Set the password for ${CYAN}$NEWUSER${NC}"
passwd $NEWUSER

########################
# install the Desktop, if it was desired

if [[ $DESKTOP != "none" ]] ; then
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
chmod 640 /home/$NEWUSER/.ssh/\*

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
