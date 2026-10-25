#!/bin/sh

# === ENVIRONMENT VARIABLES ===
export XDG_CURRENT_DESKTOP=i3
export XDG_SESSION_DESKTOP="${XDG_CURRENT_DESKTOP}"
export XDG_SESSION_TYPE=x11
export _JAVA_AWT_WM_NONREPARENTING=1
# qt6ct also answers to qt5ct, so Qt 5 and Qt 6 apps both get the Dracula theme
export QT_QPA_PLATFORMTHEME=qt5ct

# === LOGGING SETUP ===
XLOG_DIR="${HOME}/.local/share/xorg"
WM_LOG="${XLOG_DIR}/${XDG_CURRENT_DESKTOP}.log"

# Rotate window manager log
[ -f "${WM_LOG}" ] && mv "${WM_LOG}" "${WM_LOG}.old"

# === X RESOURCES ===
SYS_RESOURCES="/etc/X11/xinit/.Xresources"
SYS_MODMAP="/etc/X11/xinit/.Xmodmap"
USER_RESOURCES="${HOME}/.Xresources"
USER_MODMAP="${HOME}/.Xmodmap"

# Merge system resources
[ -f "${SYS_RESOURCES}" ] && xrdb -merge "${SYS_RESOURCES}"
[ -f "${SYS_MODMAP}" ] && xmodmap "${SYS_MODMAP}"

# Merge user resources
[ -f "${USER_RESOURCES}" ] && xrdb -merge "${USER_RESOURCES}"
[ -f "${USER_MODMAP}" ] && xmodmap "${USER_MODMAP}"

# === STARTUP SCRIPTS ===
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        # shellcheck disable=SC1090
        [ -x "${f}" ] && . "${f}"
    done
    unset f
fi

# === DISPLAY CONFIGURATION ===
# Apply the saved autorandr profile for the connected monitors, or stack them
# side by side when none matches
autorandr --change --default horizontal

# === SCREEN BLANKING ===
# Blank and lock (via xss-lock) after 10 minutes idle, held off by
# stay-awake-media while audio is playing or a window is fullscreen
xset s 600

# === STARTUP APPLICATIONS ===
# Background services
picom &
unclutter &
lxpolkit &
dunst &
xss-lock --transfer-sleep-lock -- lock-screen &
stay-awake-media &
udiskie &

# Desktop setup
random-wallpaper
numlockx on

# === WINDOW MANAGER ===
exec "${XDG_CURRENT_DESKTOP}" >>"${WM_LOG}" 2>&1
