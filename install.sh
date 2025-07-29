#!/bin/bash

# Dotfiles installation and system configuration

# === PERMISSION CHECK ===
# Ensure script is not run as root
if [[ "$(id -u)" -eq 0 ]]; then
    echo "This script can't be run as root"
    exit 1
fi

# === SYSTEM FILE PERMISSIONS ===
# Recursively set correct permissions for system files
set_permissions() {
    local path="$1"
    for file in "$path"/*; do
        if [[ -d "$file" ]]; then
            sudo chmod 755 "$file"
            set_permissions "$file"
        elif [[ -f "$file" ]]; then
            sudo chmod 644 "$file"
        fi
    done
}

# Apply permissions to system directory
set_permissions "${PWD}/system"

# === USER CONFIGURATION ===
# Install user dotfiles to home directory
cp -a "${PWD}/dotfiles/." "${HOME}"

# === FILESYSTEM CONFIGURATION ===
# Get UUID of current root filesystem
DRIVE_UUID=$(sudo findmnt -fn -o UUID /)

# Update fstab with actual UUID
sed -i "s#\$DRIVE_UUID#${DRIVE_UUID}#g" "system/etc/fstab"

# === SYSTEM FILES INSTALLATION ===
# Store current user for permission restoration
current_user=$(whoami)

# Set root ownership for system files
sudo chown root:root -R "${PWD}/system/"

# Install system configuration files
sudo cp -a "${PWD}/system/." /

# Restore user ownership of source files
sudo chown "${current_user}:${current_user}" -R "${PWD}/system/"

# === MOUNT POINT CONFIGURATION ===
# Create mount points defined in fstab
mount_points=$(awk '$1 !~ /^#/ && $2 != "/" && $2 != "" {print $2}' /etc/fstab)

for mount_point in ${mount_points}; do
    sudo mkdir -p "${mount_point}"
    sudo chown "${current_user}:${current_user}" "${mount_point}"
done

# === EXECUTABLE PERMISSIONS ===
# Make user scripts executable
if [[ -d "${HOME}/.local/bin" ]]; then
    chmod u+x "${HOME}/.local/bin/"*
fi

# === XDG USER DIRECTORIES ===
# Create standard user directories
if [[ -f "${HOME}/.config/user-dirs.dirs" ]]; then
    # Extract directory paths from XDG config
    while IFS= read -r line; do
        if [[ "$line" =~ ^[^#]*\"(.*)\" ]]; then
            dir_path="${BASH_REMATCH[1]}"
            # Expand $HOME variable
            dir_path="${dir_path/\$HOME/${HOME}}"
            mkdir -p "${dir_path}" 2>/dev/null
        fi
    done < "${HOME}/.config/user-dirs.dirs"
fi

# === SYSTEM UPDATE ===
# Regenerate initramfs to apply kernel changes
sudo mkinitcpio -P