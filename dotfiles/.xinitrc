#!/bin/sh

export XDG_CURRENT_DESKTOP=dwm
export XDG_SESSION_DESKTOP="$XDG_CURRENT_DESKTOP"
export XDG_SESSION_TYPE=X11
export _JAVA_AWT_WM_NONREPARENTING=1

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd --all

xrandr --output HDMI-1 --mode 2560x1440 -r 144 --primary
xrandr --output DP-1 --mode 1920x1080 -r 60 --right-of HDMI-1
xset s off -dpms #Disable DPMS and prevent screen from blanking

numlockx
wal -Rstq #Set background and theme from cache with pywal
picom &
unclutter &
lxpolkit &
dwmblocks &
exec dwm
