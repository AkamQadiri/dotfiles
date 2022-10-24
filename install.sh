#!/bin/sh

#Copy files to home directory
cp -a $PWD/{.config,.local,.bash_profile,.bashrc,.xinitrc,wallpapers} $HOME

#Copy setup files to destinations
sudo cp $PWD/setup/xorg.conf.d/* /etc/X11/xorg.conf.d/

#Setup profile
sudo sh -c 'echo "" >> /etc/profile'
sudo sh -c 'echo "wal -i ~/wallpapers -steq" >> /etc/profile'

#Make local binaries executable
chmod u+x ~/.local/bin/*