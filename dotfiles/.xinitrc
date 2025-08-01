#!/bin/sh

export XDG_CURRENT_DESKTOP=i3
export XDG_SESSION_DESKTOP="$XDG_CURRENT_DESKTOP"
export XDG_SESSION_TYPE=X11
export _JAVA_AWT_WM_NONREPARENTING=1

xlogdir=$HOME/.local/share/xorg
wmlogpath="$xlogdir/$XDG_CURRENT_DESKTOP.log"
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# move previous dwm log if exists
if [ -f "$wmlogpath" ]; then
    mv "$wmlogpath" "$wmlogpath.old"
fi

# configure monitors
xrandr --output DP-2 --mode 2560x1440 -r 144 --primary \
    --output DP-0 --mode 1920x1080 -r 144 --right-of DP-2
xset s off -dpms # disable DPMS and prevent screen from blanking

# start necessary programs
random-wallpaper
numlockx
picom &
unclutter &
lxpolkit &
exec $XDG_CURRENT_DESKTOP >>"$wmlogpath" 2>&1
