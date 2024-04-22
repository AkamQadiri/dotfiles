#!/bin/sh

if [ $EUID -eq 0 ]; then
  echo "This script can't be run as root"
  exit
fi

# Set system files permissions
set_permissions() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            sudo chmod 755 "$file"
            set_permissions "$file"
        elif [ -f "$file" ]; then
            sudo chmod 644 "$file"
        fi
    done
}
set_permissions "$PWD/system"

# Install dotfiles
cp -a $PWD/dotfiles/. $HOME

# Retrieve the Name and UUID of the drive currently running the Linux system
DRIVE_NAME=$(findmnt -no SOURCE /)
DRIVE_UUID=$(lsblk -no UUID $DRIVE_NAME)

# Replace placeholder with actual values
sed -i "s#\$DRIVE_UUID#$DRIVE_UUID#g" "system/etc/fstab"

# Install system files
current_user=$(whoami)
sudo chown root:root -R $PWD/system/
sudo cp -a $PWD/system/. /
sudo chown $current_user:$current_user -R $PWD/system/

# Get mount points listed in fstab
mount_points=$(awk '$1 !~ /^#/ && $2 != "/" && $2 != "" {print $2}' /etc/fstab)

# Create mount points and set permissions
for mount_point in $mount_points; do
    sudo mkdir -p $mount_point
    sudo chown $current_user:$current_user $mount_point
done

# Enable systemd services
sudo systemctl daemon-reload
sudo systemctl --now enable hdd-sleep

# Make local binaries executable
chmod u+x ~/.local/bin/*

# Create default dirs
default_dirs=$(cat $HOME/.config/user-dirs.dirs | awk -F '"' '/^[^#]/ {print $2}' | sed 's/$HOME//')

for default_dir in ${default_dirs[@]}; do
	mkdir "$HOME$default_dir" 2>/dev/null
done

# Regenerate initramfs and GRUB config
sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg
