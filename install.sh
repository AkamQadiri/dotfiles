#!/bin/bash
# shellcheck disable=SC1091
set -euo pipefail

# Dotfiles installation and system configuration

# === PERMISSION CHECK ===
if [[ "$(id -u)" -eq 0 ]]; then
    echo "Error: This script cannot be run as root"
    exit 1
fi

# === CONFIGURATION ===
DOTFILES_DIR="${PWD}/dotfiles"
SYSTEM_DIR="${PWD}/system"

# === FUNCTIONS ===
set_permissions() {
    local path="$1"
    find "${path}" -type d -exec sudo chmod 755 {} \;
    find "${path}" -type f -exec sudo chmod 644 {} \;
}

# === SYSTEM FILE PERMISSIONS ===
echo "Setting system file permissions..."
set_permissions "${SYSTEM_DIR}"

# === USER CONFIGURATION ===
echo "Installing user dotfiles..."
cp -a "${DOTFILES_DIR}/." "${HOME}/"

# === FILESYSTEM CONFIGURATION ===
echo "Configuring filesystem..."
DRIVE_UUID=$(findmnt -no UUID /)

# Update fstab with actual UUID
sudo sed -i "s/\$DRIVE_UUID/${DRIVE_UUID}/g" "${SYSTEM_DIR}/etc/fstab"

# === SYSTEM FILES INSTALLATION ===
echo "Installing system configuration files..."

# Store current user for permission restoration
CURRENT_USER=$(whoami)

# Set root ownership for system files
sudo chown root:root -R "${SYSTEM_DIR}/"

# Install system configuration files (preserves ownership)
sudo cp -a "${SYSTEM_DIR}/." /

# Restore user ownership of source files
sudo chown "${CURRENT_USER}:${CURRENT_USER}" -R "${SYSTEM_DIR}/"

# === MOUNT POINT CONFIGURATION ===
echo "Creating mount points..."
while IFS= read -r mount_point; do
    [[ -z "${mount_point}" ]] && continue
    sudo mkdir -p "${mount_point}"
    sudo chown "${CURRENT_USER}:${CURRENT_USER}" "${mount_point}"
done < <(awk '$1 !~ /^#/ && $2 != "/" && $2 != "" {print $2}' /etc/fstab)

# === EXECUTABLE PERMISSIONS ===
echo "Setting executable permissions..."
find "${HOME}/.local/bin" -type f -exec chmod u+x {} \; 2>/dev/null || true

# === XDG USER DIRECTORIES ===
echo "Creating XDG user directories..."
if [[ -f "${HOME}/.config/user-dirs.dirs" ]]; then
    # Source the file to get variables
    source "${HOME}/.config/user-dirs.dirs"

    # Create each directory
    for dir in XDG_DESKTOP_DIR XDG_DOWNLOAD_DIR XDG_TEMPLATES_DIR \
        XDG_PUBLICSHARE_DIR XDG_DOCUMENTS_DIR XDG_MUSIC_DIR \
        XDG_PICTURES_DIR XDG_VIDEOS_DIR; do
        # Get the value of the variable
        dir_path="${!dir:-}"
        [[ -z "${dir_path}" ]] && continue

        # Expand $HOME
        dir_path="${dir_path//\$HOME/${HOME}}"
        mkdir -p "${dir_path}"
    done
fi

# === SYSTEM UPDATE ===
echo "Regenerating initramfs..."
sudo mkinitcpio -P

echo "Installation complete!"
