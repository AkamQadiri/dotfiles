# ~/.bashrc
# Bash interactive shell configuration

# === SHELL BEHAVIOR ===
# Exit if not running interactively
[[ $- != *i* ]] && return

# === PROMPT ===
PS1='[\u@\h \W]\$ '

# === HISTORY ===
export HISTCONTROL='ignoreboth:erasedups'
export HISTSIZE=10000
export HISTFILESIZE=20000

# === ENVIRONMENT VARIABLES ===
export TERMINAL='ghostty'
export EDITOR='nvim'
export VISUAL='nvim'
export BROWSER='firefox'

# === PATH ADDITIONS ===
export PATH="${PATH}:${HOME}/.local/bin"

# Android development
export ANDROID_HOME="${HOME}/Android/Sdk"
export PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
export PATH="${PATH}:${ANDROID_HOME}/emulator"
export PATH="${PATH}:${ANDROID_HOME}/platform-tools"

# Node.js tools
export PATH="${PATH}:${HOME}/.yarn/bin"
export PATH="${PATH}:${HOME}/.npm/bin"

# .NET tools
export PATH="${PATH}:${HOME}/.dotnet/tools"

# === ALIASES ===
# System shortcuts
alias shutdown='pve shutdown 200'
alias reboot='pve reboot 200'

# Command improvements
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias vim='nvim'
