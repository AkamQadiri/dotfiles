#!/bin/sh

#Copy files to home directory
cp -a $PWD/{.config,.local,.bash_profile,.bashrc,.xinitrc,wallpapers} $HOME

#Copy setup files to destinations
sudo cp $PWD/setup/profile.d/* /etc/profile.d/
sudo cp $PWD/setup/xorg.conf.d/* /etc/X11/xorg.conf.d/

#Make local binaries executable
chmod u+x ~/.local/bin/*