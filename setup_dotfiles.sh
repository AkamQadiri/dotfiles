sudo cp ~/setup/xorg.conf.d/* /etc/X11/xorg.conf.d/

sudo sh -c 'echo "" >> /etc/profile'
sudo sh -c 'echo "wal -i ~/wallpapers -steq" >> /etc/profile'

sudo rm -r ~/setup
sudo rm setup_dotfiles.sh
