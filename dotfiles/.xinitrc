#!/bin/sh

# === ENVIRONMENT VARIABLES ===
export XDG_CURRENT_DESKTOP=i3
export XDG_SESSION_DESKTOP="${XDG_CURRENT_DESKTOP}"
export XDG_SESSION_TYPE=X11
export _JAVA_AWT_WM_NONREPARENTING=1

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
# Configure monitors
xrandr --output DP-2 --mode 2560x1440 --rate 144 --primary \
    --output DP-0 --mode 1920x1080 --rate 144 --right-of DP-2

# Disable screen blanking
xset s off -dpms

# === STARTUP APPLICATIONS ===
# Background services
picom &
unclutter &
lxpolkit &
dunst &

# Desktop setup
random-wallpaper
numlockx on

# === WINDOW MANAGER ===
exec "${XDG_CURRENT_DESKTOP}" >>"${WM_LOG}" 2>&1
