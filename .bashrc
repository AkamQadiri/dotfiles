#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

export TERMINAL="st"
export EDITOR="vim"
export PATH="${PATH}:${HOME}/.local/bin/"

(cat ~/.cache/wal/sequences &) #Set terminal theme from pywal generated file
source ~/.cache/wal/colors-tty.sh #Set tty theme from pywal generated file

alias ls='ls --color=auto'
alias shutdown='sudo shutdown now'
alias reboot='sudo reboot now'

pfetch
