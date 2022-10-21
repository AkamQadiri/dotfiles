#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

(cat ~/.cache/wal/sequences &)    #Set terminal theme from pywal generated file
source ~/.cache/wal/colors-tty.sh #Set tty theme from pywal generated file

export PATH="${PATH}:${HOME}/.local/bin/"
export HISTCONTROL=ignoreboth:erasedups
export TERMINAL="st"
export EDITOR="vim"

alias ls='ls --color=auto'
alias shutdown='sudo shutdown now'
alias reboot='sudo reboot now'

pfetch
