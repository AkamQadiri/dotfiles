#!/bin/sh

export XDG_CURRENT_DESKTOP=dwm
export XDG_SESSION_DESKTOP="$XDG_CURRENT_DESKTOP"
export _JAVA_AWT_WM_NONREPARENTING=1

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

numlockx
wal -Rstq #Set background and theme from cache with pywal
picom &
unclutter &
lxpolkit &
dwmblocks &
exec dwm