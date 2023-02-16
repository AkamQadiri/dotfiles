#!/bin/sh

#Copy files to home directory
cp -a $PWD/{.config,.local,.bash_profile,.bashrc,.xinitrc,wallpapers} $HOME

#Copy setup files to destinations
sudo cp $PWD/setup/profile.d/* /etc/profile.d/
sudo cp $PWD/setup/rules.d/* /etc/udev/rules.d/
sudo cp $PWD/setup/xorg.conf.d/* /etc/X11/xorg.conf.d/

#Make local binaries executable
chmod u+x ~/.local/bin/*

#Create default dirs
default_dirs=$(cat ~/.config/user-dirs.dirs | awk -F '"' '/^[^#]/ {print $2}' | sed 's/$HOME//')

for default_dir in ${default_dirs[@]}; do
	mkdir "$HOME$default_dir" 2>/dev/null
done