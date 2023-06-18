# Setup

My dotfiles setup for Arch Linux and Windows, managed by [chezmoi](https://github.com/twpayne/chezmoi).

## Table of Contents

1. [Arch Linux](#arch-linux)
2. [Install](#install)

## Arch Linux

On Arch Linux I have setups for both X11 and Wayland.

This is my current system theme:

| Theme                   | Theme Name                 |
|-------------------------|----------------------------|
| Setup                   | Firewatch                  |
| GTK Icon Theme          | `Flat-Remix-GTK-Red-Light` |
| GTK Window Theme        | `Flat-Remix-Red-Light`     |
| Terminal Emulator Theme | `base16-horizon-dark-256`  |
| Terminal Emulator Font  | `Inconsolata Nerd Font`    |
| Mouse Cursor            | `Adwaita`                  |

These are the applications I use.

| Application Type                  | Application Name | Wayland Alternative |
|-----------------------------------|------------------|---------------------|
| Terminal Emulator                 | `alacritty`      |                     |
| Terminal Multiplexer              | `tmux`           |                     |
| Text Editor                       | `neovim`         |                     |
| Shell                             | `zsh`            |                     |
| File Browser                      | `thunar`         |                     |
| Wallpaper Manager                 | `fehbg`          |                     |
| Login Greeter                     | `sddm`           |                     |
| Desktop Environment               | `i3-wm`          | `sway`*             |
| Status Bar                        | `polybar`        | `waybar`            |
| Music Player                      | `mpd`            |                     |
| Application Launcher              | `rofi`           |                     |
| Compositor                        | `picom`          | `sway`*             |
| Screenshot Manager                | `flameshot`      |                     |
| Notification Daemon               | `dunst`          |                     |
| Adaptive Screen Brightness Daemon | `clightd`        | `clightd`           |
| Adaptive Screen Bluelight Daemon  | `redshift`       | `gammastep`         |
| IRC Client                        | `weechat`        |                     |
| Web Browser                       | `firefox`        |                     |
| Data Backups                      | `borg`           |                     |
| Email Application                 | `thunderbird`    |                     |
| Vector Graphics Editor            | `inkscape`       |                     |
| Raster Graphics Editor            | `krita`          |                     |

- **\*Note:** I use the [sway-nvidia](https://aur.archlinux.org/packages/sway-nvidia) package as I have to have compatibility with NVidia drivers.

Some additional apps I use are:
- `micromamba`
- `signal`
- `element`
- `pipewire` and `pulseaudio`

- **Note:** I make use of a lot of file path aliases generated via a program I made called `shortpath`.
- **Note:** My executable scripts can be found in `~/.local/scripts`. My setup scripts are in `~/.config/dotfiles/scripts`

## Install

To install:
``` bash
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply jmdaemon
```

To update:
``` bash
chezmoi update
```
