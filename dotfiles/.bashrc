# shellcheck disable=SC1091
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

# === FZF CONFIGURATION ===
# Source fzf keybindings and completion
[[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash

# Dracula theme for fzf
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

export FZF_CTRL_T_OPTS="
    --preview 'file -b {} 2> /dev/null | head -1; echo; head -50 {}'
    --preview-window=right:50%:wrap"

export FZF_ALT_C_OPTS="
    --preview 'ls -la {}'
    --preview-window=right:50%:wrap"

# === NNN CONFIGURATION ===
# Dracula theme colors for nnn
export NNN_FCOLORS="D4DEB778E79F9F67D2E5E5D2"

# nnn settings
export NNN_BMS="d:~/downloads;D:~/documents;p:~/pictures;v:~/videos;c:~/.config"
export NNN_PLUG='f:fzopen;z:fzcd;p:preview-tui'
export NNN_FIFO='/tmp/nnn.fifo'
export NNN_PREVIEWIMGPROG="chafa -c 256 -s 100x50"
export NNN_TERMINAL="$TERMINAL"

if [ -f /usr/share/nnn/quitcd/quitcd.bash_sh_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_sh_zsh
fi

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
