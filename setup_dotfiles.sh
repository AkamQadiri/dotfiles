#!/bin/sh

USERHOME=$HOME

#Copy files to home directory
cp -a $PWD/. $USERHOME

#Copy setup files
sudo cp $USERHOME/setup/xorg.conf.d/* /etc/X11/xorg.conf.d/

#Setup profile
sudo sh -c 'echo "" >> /etc/profile'
sudo sh -c 'echo "wal -i ~/wallpapers -steq" >> /etc/profile'

#Make local binaries executable
sudo chmod u+x $USERHOME/.local/bin/*

#Cleanup
sudo rm -r $USERHOME/.git
sudo rm -r $USERHOME/setup
sudo rm -r $USERHOME/setup_dotfiles.sh
