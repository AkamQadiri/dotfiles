#
# ~/.bash_profile
#

xlogdir=$HOME/.local/share/xorg

[[ -f ~/.bashrc ]] && . ~/.bashrc

# create xorg log directory
mkdir -p "$xlogdir"

# move previous startx log if exists
if [ -f "$xlogdir/startx.log" ]; then
    mv "$xlogdir/startx.log" "$xlogdir/startx.log.old"
fi

startx >>"$xlogdir/startx.log" 2>&1
