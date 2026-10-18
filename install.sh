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
# Relative to this script, so it works from any directory
REPO_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
DOTFILES_DIR="${REPO_DIR}/dotfiles"
SYSTEM_DIR="${REPO_DIR}/system"

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

# === DESKTOP THEME ===
# Apps that ask the desktop portal or GSettings instead of reading the GTK
# settings files (libadwaita, Electron, browsers) get dark mode and Dracula too
# GSettings only saves over a D-Bus session, so start one when there is none,
# as in the archinstall chroot
echo "Setting desktop theme preferences..."
GSETTINGS=(gsettings)
if [[ -z "${DBUS_SESSION_BUS_ADDRESS:-}" && ! -S "${XDG_RUNTIME_DIR:-}/bus" ]]; then
    GSETTINGS=(dbus-run-session -- gsettings)
fi
"${GSETTINGS[@]}" set org.gnome.desktop.interface color-scheme prefer-dark
"${GSETTINGS[@]}" set org.gnome.desktop.interface gtk-theme Dracula
"${GSETTINGS[@]}" set org.gnome.desktop.interface icon-theme Dracula

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
