#!/bin/sh

#Install dotfiles
cp -a $PWD/dotfiles/* $HOME

#Install system files
sudo cp -a $PWD/system/* /

#Enable systemd services
sudo systemctl --now enable hdd-sleep

#Make local binaries executable
chmod u+x ~/.local/bin/*

#Create default dirs
default_dirs=$(cat $HOME/.config/user-dirs.dirs | awk -F '"' '/^[^#]/ {print $2}' | sed 's/$HOME//')

for default_dir in ${default_dirs[@]}; do
	mkdir "$HOME$default_dir" 2>/dev/null
done