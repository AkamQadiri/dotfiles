#!/bin/sh

#Copy files to home directory
cp -a $PWD/. $HOME

#Copy setup files to destinations
sudo cp $HOME/setup/xorg.conf.d/* /etc/X11/xorg.conf.d/

#Setup profile
sudo sh -c 'echo "" >> /etc/profile'
sudo sh -c 'echo "wal -i ~/wallpapers -steq" >> /etc/profile'

#Make local binaries executable
chmod u+x ~/.local/bin/*

#Cleanup
rm -rf ~/.git
rm -rf ~/setup
rm -rf ~/install.sh