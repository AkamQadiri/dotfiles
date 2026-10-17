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
| Bluetooth      | bluetui                                  |
| Terminal       | Ghostty                                  |
| Shell          | Bash                                     |
| Editor         | Neovim (lazy.nvim)                       |
| File manager   | nnn                                      |
| Theme          | Dracula (GTK, Qt, terminal, app configs) |

The GTK theme and icons come from the AUR packages `dracula-gtk-theme` and `dracula-icons-git` (installed by archinstall). `~/.config/gtk-4.0` imports the theme for GTK 4 and libadwaita apps, which only read it from there.

Keyboard layout is Norwegian (`no`). Displays are set by `autorandr` at login and on monitor hotplug, from the profile saved for the connected monitors (`autorandr --save <name>`). With no matching profile, every screen gets its largest resolution at its highest refresh rate, side by side, with the largest screen as primary (`~/.config/autorandr/postswitch`). The screen blanks and locks after 10 minutes idle.

On a laptop, closing the lid suspends, then hibernates before the battery runs out. The i3blocks battery block (with notifications below 15% and at 5%), the brightness block and the brightness keys only do anything on a laptop. The touchpad gets tap-to-click, natural scrolling and a flat acceleration profile, like the mouse.

USB drives are automounted by udiskie under `/run/media/$USER/`, with a notification on mount and unmount.

The network block shows an Ethernet icon while a cable is connected, the WiFi icon with signal strength while connected (plain when WiFi is on but not connected, dimmed when it is off), and a lock icon while a VPN is up. While a cable is connected it carries the traffic, so the WiFi icon is dimmed when WiFi is on and hidden when it is off. Left click opens nmtui, right click turns WiFi on or off.

When a Bluetooth adapter is present, an i3blocks block shows whether Bluetooth is on and how many devices are connected. Left click opens bluetui, right click turns Bluetooth on or off.

The power profile block shows an icon for the active profile (leaf for power saver, scale for balanced, rocket for performance) when tlp-pd or power-profiles-daemon is running. Left click cycles to the next profile, right click to the previous one, and a notification names the new profile.

The brightness block shows the screen brightness. Scrolling changes it in 5% steps like the brightness keys, and left click sets full brightness.

The do not disturb block shows a bell while notifications are shown and a dimmed crossed out bell while dunst holds them back. Left click toggles it, and held back notifications show up once it is turned off.

## Layout

- `dotfiles/` — files that map into `$HOME` (configs, scripts, X startup)
- `system/` — files that map into `/` (X11 mouse/touchpad/keyboard config, logind lid switch, TLP Bluetooth exclusion, udev rules)
- `install.sh` — copies both trees into place and runs first-time setup

`~/.local/bin` holds a few helper scripts: `backup-github`, `clean-system`, `pack-project`, `pve` (Proxmox VM control), and `random-wallpaper`.

## Install

> [!WARNING]
> This is tuned to my hardware. `install.sh` copies files into system
> directories. Read it first and adjust the hardware-specific pieces — the
> `autorandr` profile for your monitors, the webcam rule under
> `system/etc/udev/`, and the keyboard layout — before running.

```sh
git clone https://github.com/<your-username>/dotfiles.git
cd dotfiles
./install.sh
```

Run it as your normal user, not root (the script refuses root).
