# Setup

1. [Arch Linux](#arch-linux)
2. [Install](#install)

My dotfiles setup, managed by [chezmoi](https://github.com/twpayne/chezmoi).

## Arch Linux

On Arch Linux I have setups for both X11 and Wayland.

These are the applications I use.

| Application Type                  | Application Name | Wayland Alternative |
|-----------------------------------|------------------|---------------------|
| Terminal Emulator                 | `alacritty`      |                     |
| Terminal Multiplexer              | `tmux`           |                     |
| Text Editor                       | `neovim`         |                     |
| Shell                             | `zsh`            |                     |
| Wallpaper Manager                 | `fehbg`          |                     |
| Desktop Environment               | `i3-wm`          | `sway`*             |
| Status Bar                        | `polybar`        | `swaybar`           |
| Music Player                      | `mpd`            |                     |
| Application Launcher              | `rofi`           |                     |
| Compositor                        | `picom`          | `sway`*             |
| Screenshot Manager                | `flameshot`      |                     |
| Notification Daemon               | `dunst`          |                     |
| Adaptive Screen Brightness Daemon | `clightd`        | `clightd`           |
| Adaptive Screen Bluelight Daemon  | `redshift`       | `gammastep`         |
| Web Browser                       | `firefox`        |                     |
| Email Application                 | `thunderbird`    |                     |
| Vector Graphics Editor            | `inkscape`       |                     |
| Raster Graphics Editor            | `krita`          |                     |

- **\*Note:** I use the [sway-nvidia](https://aur.archlinux.org/packages/sway-nvidia) package as I have to have compatibility with NVidia drivers.

Additional applications I use are:
- `micromamba`
- `msmtp`

I also make use of a lot of aliases, custom bash functions and executables which you can find in
`~/.config/dotfiles/scripts/{aliases/startup}`

## Install

To install:
``` bash
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply jmdaemon
```

To update:
``` bash
chezmoi update
```
