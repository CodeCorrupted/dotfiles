# BSPWM Configuration

Minimal configuration for bspwm, made for Artix with OpenRC as init and X11
as window display server.

## Installation

Install required dependencies, which are executed at start:

```sh
sudo pacman -S --needed \
  xwallpapper picom connman-gtk polybar redshift udiskie dunst
  mpd blueman-applet xautolock wmname sxhkd xorg-apps connman-openrc

yay -S betterlockscreen
```

You also need from this dotfiles:

- The script `battery_check.sh`.
- Config of `polybar` (or at least the `launch.sh` script under
  `~/.config/polybar/` directory)
- `mpd` (or your config at `~/.config/mpd/`)
- `dunst` (or your own config under `~/.config/dunst/`, modifying the line 33
  of `autostart.sh` to charge your config file)
- `sxhkd` to get keybindings on `bspwm` (or you can use your own configuration)

Then, you have to clone this repository and do:

```sh
mkdir -p ~/.config/bspwm/
cp dotfiles/.config/bspwm/*.sh dotfiles/bspwm/bspwmrc ~/.config/bspwm/
```

And edit the line 15 to set your wallpapper and run `betterlockscreen` to set
a lock-wallpapper. You can also use the scripts `set_update_wallpapper.sh` and
`set_lock_wallpapper.sh` if you want (read the README file on that directory to
get more info).

## Features

- **Ten** desktops
- Gapless monocle mode, 2px borders and 12px gaps.
- **Smart floating rules** for:
  - Emulators.
  - Utilities.
  - System tools
  - Menus, pop-up, etc.
- Runs java applications without problems.

## Customize

If you need to do changes:

- **autostart.sh**: run services and daemons.
- **bspwmrc**: setup desktops, gaps and other things of bspwm.
- **external_rules.sh**: set floating windows by roles.
