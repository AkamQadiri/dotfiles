#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

export PATH="${PATH}:${HOME}/.local/bin/"
export HISTCONTROL='ignoreboth:erasedups'
export TERMINAL='ghostty'
export EDITOR='nvim'
export ANDROID_HOME="${HOME}/Android/Sdk"
export PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
export PATH="${PATH}:${ANDROID_HOME}/emulator"
export PATH="${PATH}:${ANDROID_HOME}/platform-tools"
export PATH="${PATH}:${HOME}/.yarn/bin"
export PATH="${PATH}:${HOME}/.dotnet/tools"

alias shutdown='pve shutdown 200'
alias ls='ls --color=auto'
alias vim="nvim"
