# dotfiles

Personal configuration for an Arch Linux desktop built around i3, themed with Dracula throughout.

## Stack

| Role           | Choice                                   |
| -------------- | ---------------------------------------- |
| OS             | Arch Linux                               |
| Window manager | i3                                       |
| Status bar     | i3blocks                                 |
| Compositor     | picom                                    |
| Notifications  | dunst                                    |
| Launcher       | rofi                                     |
| Screen locker  | i3lock via xss-lock                      |
| Automount      | udiskie                                  |
| Terminal       | Ghostty                                  |
| Shell          | Bash                                     |
| Editor         | Neovim (lazy.nvim)                       |
| File manager   | nnn                                      |
| Theme          | Dracula (GTK, Qt, terminal, app configs) |

Keyboard layout is Norwegian (`no`); the display setup assumes two monitors (DP-2 at 2560×1440, DP-0 at 1920×1080).

On a laptop (detected by a battery under `/sys/class/power_supply`), `.xinitrc` applies a saved `autorandr` profile instead and blanks and locks the screen after 10 minutes idle. Closing the lid suspends, then hibernates before the battery runs out. The i3blocks battery block (with notifications below 15% and at 5%) and the brightness keys only do anything on a laptop. The touchpad gets tap-to-click, natural scrolling and a flat acceleration profile, like the mouse.

USB drives are automounted by udiskie under `/run/media/$USER/`, with a notification on mount and unmount.

## Layout

- `dotfiles/` — files that map into `$HOME` (configs, scripts, X startup)
- `system/` — files that map into `/` (X11 mouse/touchpad/keyboard config, `fstab` with the swapfile, logind lid switch, udev rules)
- `install.sh` — copies both trees into place and runs first-time setup

`~/.local/bin` holds a few helper scripts: `backup-github`, `clean-system`, `pack-project`, `pve` (Proxmox VM control), and `random-wallpaper`.

## Install

> [!WARNING]
> This is tuned to my hardware. `install.sh` copies files into system
> directories, rewrites the root UUID in `/etc/fstab`, creates mount points
> for any extra `fstab` entries, and regenerates the initramfs with
> `mkinitcpio -P`. Read it first and adjust the hardware-specific pieces — the
> monitor layout in `.xinitrc`, the webcam rule under `system/etc/udev/`, and
> the keyboard layout — before running.

```sh
git clone https://github.com/<your-username>/dotfiles.git
cd dotfiles
./install.sh
```

Run it as your normal user, not root (the script refuses root).
