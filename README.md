# Dotfiles

## Setup

My dotfiles are managed by [chezmoi](https://github.com/twpayne/chezmoi).

### X11:

I use these applications for my X11 setup on Arch Linux:

| Application Type     | Application Name |
|----------------------|------------------|
| Terminal Emulator    | `alacritty`      |
| Text Editor          | `neovim`         |
| Shell                | `zsh`            |
| Wallpaper Manager    | `fehbg`          |
| Desktop Environment  | `i3-wm`          |
| Status Bar           | `polybar`        |
| Music Player         | `mpd`            |
| Application Launcher | `rofi`           |
| Compositor           | `picom`          |
| Screenshot Manager   | `flameshot`      |
| Notification Daemon  | `dunst`          |
| Web Browser          | `firefox`        |

### Wayland:

My Wayland setup for Arch Linux:

| Application Type     | Application Name | Wayland Alternative |
|----------------------|------------------|---------------------|
| Terminal Emulator    | `alacritty`      |                     |
| Text Editor          | `neovim`         |                     |
| Shell                | `zsh`            |                     |
| Wallpaper Manager    | `fehbg`          |                     |
| Desktop Environment  | `i3-wm`          | `sway`              |
| Status Bar           | `polybar`        | `swaybar`           |
| Music Player         | `mpd`            |                     |
| Application Launcher | `rofi`           |                     |
| Compositor           | `picom`          | `sway`              |
| Screenshot Manager   | `flameshot`      |                     |
| Notification Daemon  | `dunst`          |                     |
| Web Browser          | `firefox`        |                     |

I make use of a lot of different programs including but not limited to:

- inkscape
- krita
- clightd
- redshift
- msmtp
- tmux

I also make use of a lot of aliases, custom bash functions and executables which you can find in
`~/.config/dotfiles/scripts/{aliases/startup}`

## Installation

To install my dotfiles:
``` bash
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply jmdaemon
```

To update your dotfiles:
```
chezmoi update
```
