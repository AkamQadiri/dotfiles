#!/bin/sh

#Copy setup files
sudo cp ~/setup/xorg.conf.d/* /etc/X11/xorg.conf.d/

#Setup profile
sudo sh -c 'echo "" >> /etc/profile'
sudo sh -c 'echo "wal -i ~/wallpapers -steq" >> /etc/profile'

#Make local binaries executable
sudo chmod u+x ~/.local/bin

#Cleanup
sudo rm -r ~/setup
sudo rm setup_dotfiles.sh
