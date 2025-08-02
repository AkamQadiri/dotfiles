# ~/.bash_profile
# Executed for login shells

# === ENVIRONMENT SETUP ===
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/state"

# === SOURCE BASHRC ===
[[ -f ~/.bashrc ]] && . ~/.bashrc

# === X11 STARTUP ===
# Start X11 if on tty1
if [[ -z "${DISPLAY}" ]] && [[ "${XDG_VTNR}" -eq 1 ]]; then
    # Create log directory
    XLOG_DIR="${XDG_DATA_HOME}/xorg"
    mkdir -p "${XLOG_DIR}"

    # Rotate logs
    [[ -f "${XLOG_DIR}/startx.log" ]] &&
        mv "${XLOG_DIR}/startx.log" "${XLOG_DIR}/startx.log.old"

    # Start X11
    exec startx >>"${XLOG_DIR}/startx.log" 2>&1
fi
