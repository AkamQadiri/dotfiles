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
    find "${path}" -type d -exec chmod 755 {} \;
    find "${path}" -type f -exec chmod 644 {} \;
}

# === USER CONFIGURATION ===
echo "Installing user dotfiles..."
cp -a "${DOTFILES_DIR}/." "${HOME}/"

# === SYSTEM FILES INSTALLATION ===
# Install from a root-owned copy so the repository is never modified
echo "Installing system configuration files..."
STAGING_DIR=$(mktemp -d)
cp -a "${SYSTEM_DIR}/." "${STAGING_DIR}/"
set_permissions "${STAGING_DIR}"
sudo chown root:root -R "${STAGING_DIR}"
sudo cp -a "${STAGING_DIR}/." /
sudo rm -rf "${STAGING_DIR}"

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

echo "Installation complete!"
