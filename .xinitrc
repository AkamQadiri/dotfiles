#!/bin/sh

export XDG_CURRENT_DESKTOP=dwm
export XDG_SESSION_DESKTOP="$XDG_CURRENT_DESKTOP"
export XDG_SESSION_TYPE=X11
export _JAVA_AWT_WM_NONREPARENTING=1

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

xrandr --auto
xset s off -dpms #Disable DPMS and prevent screen from blanking

numlockx
wal -Rstq #Set background and theme from cache with pywal
picom &
unclutter &
lxpolkit &
dwmblocks &
exec dwm