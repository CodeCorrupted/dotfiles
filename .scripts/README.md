# Scripts Configuration

POSIX scripts used on my configurations of `i3` and `bspwm` to automatize or
improve some actions.

## Installation

You have to clone this repo and then:

```sh
# copy files
cp -r dotfiles/.scripts ~/
chmod +x ~/.scripts/*.sh ~/.scripts/*.py

# install dependencies
sudo pacman -S --needed \
  polybar i3-wm i3lock bspwm dunst acpi inotify-tools xbacklight pamixer
  wmctrl xorg-xprop mpc python dmenu rofi betterlockscreen feh xwallpapper
  python-pywal
```

If something isn't working propperly, check that every file is executable. Also,
check that you have some [patched font](https://www.nerdfonts.com/font-downloads)
because some scripts uses some special glyphs.

## Script description

### bar_tray_file_state.sh

This script runs a second instance of polybar which only shows a tray icon module.

If you don't need this, you should check the configuration of polybar and
delete/comment modules-right section on the `config.ini` file (the text that
includes the arrow-tray module) and, optionally, delete the
`.config/polybar/bar-tray.ini` and `.config/polybar/modules/arrow-tray.ini`
files.

### battery_check.sh

This script runs as a background process, started by the `autostart.sh` file of
`i3` and `bspwm`.

This script sends a notification through `dunst` to show you if the battery is:

- Charging
- With low battery (20%)
- Connected and not charging

It executes once each minute. You can set a shorter time editting the line 88
(in seconds). Also, you can edit:

- LOW: to set the level that you think is low enough to show the notification.

If you don't need this script, before delete it be sure to edit the `autostart.sh`
file of `bspwm` and/or `i3` and comment/delete the line that runs this script.

### bright_status.sh

This script runs at start of `i3`. It shows the bright level on the `i3-bar`.

If you don't need it, delete/comment the line that launch this script on the
`autostart.sh` of `i3`, and edit the configuration file on `.config/i3status`
directory, the section which displays the bright.

### brightness_control.sh

This scripts increase/decrease the brightness through `xbacklight` or `light`
commands and display a fancy notification with `dunst`. You have to pass the
arguments "up" or "down" to control the brightness and it will be modified
at 5% step.

This script is used on `.config/sxkhd/sxkhdrc`, `.config/i3/conf.d/bindings.conf`
and `.config/i3/conf.d/modes.conf`, to set keyboard shortcuts that run it. If
you don't need it, edit those files.

### dmenu_window.sh

This script displays dmenu with options to switch between the windows of
applications currently open on your system.

If you won't need it, just edit the `.config/i3/conf.d/bindings.conf` file
to delete/comment the related binding.

### label-mpd.py

This script displays the artist and name of a song being played by mpd,
keeping a length of 20 characters and scrolling the text with songs longer
than that.

If you won't use it, edit the `.config/polybar/config.ini` file to comment
the middle module of mpd-label, and delete the
`.config/polybar/modules/mpd-label.ini` file.

### power_menu_rofi.sh

This script launches a power menu using `rofi`. It depends on a config file
for the theme it uses on `.config/rofi/themes/power-menu.rasi`, rofi
and a patched font (Nerd Font).

If you don't need it, you can delete it and edit the `.config/sxkhd/sxkhdrc`
to delete the keyboard shortcut and `.config/polybar/config.ini` and
`.config/polybar/modules/power-button.ini` to get it out of the bar.

### power_menu_dmenu.sh

This script launches a power menu using `dmenu`. You must have dmenu and a patched
font installed (Nerd Font).

If you don't need it, edit the `.config/i3/conf.d/bindings.conf` file to delete
or comment the related binding.

### set_lock_wallpapper.sh

This one I use it to change the lock wallpapper, getting an image as argument.
On `bspwm`, it uses the `betterlockscreen` program, and on `i3` uses `i3lock`.

These are the files modified when you run the script under `i3`:
`.config/i3/autostart.sh`, `.config/i3/conf.d/bindings.conf` and
`.scripts/power_menu_dmenu.sh`. On `bspwm` it just run `betterlockscreen`.

This script is super usefull and, if you use my `.zshrc` file, it has an alias
for this script (`set-lock-wal`). Anyways, if you don't need it, comment/delete
the alias on `.zshrc`.

### set_update_wallpapper.sh

This script set the image received as argument as wallpapper. First, it runs
`pywal` to get a pellete, then edit the following files:

If it runs under `i3`:

- `.config/i3/conf.d/windows_display.conf` to modify the windows border color.
- `.config/i3/conf.d/bar.conf` to modify bar's colors.
- `.config/i3/conf.d/bindings.conf` to modify dmenu's colors.
- `.scripts/power_menu_dmenu.sh` to modify the power menu colors.
- `.config/dunst/dunstrc-i3` to modify the colors of dunst.
- `.config/kitty/kitty.d/colors-kitty.conf` to change the colors for Kitty
  terminal.

If it runs under `bspwm`:

- `.config/dunst/dunstrc-bspwm` to modify the colors of dunst.
- `.config/polybar/colors.ini` to modify the colors of polybar.
- `.config/bspwm/autostart.sh` to set the wallpapper and make it persistent.
- `.config/rofi/colors/theme-pywal.rasi` to change the colors of rofi.
- `.config/alacritty/colors.toml` to change the colors of Alacritty.

If you won't need this script, just need to delete/comment the alias on `.zshrc`
for this script (`set-wal`).

### volume_control.sh

This script uses `pamixer` (so it works only if you have `pulseaudio` installed)
to control the volume of the system. It receives the arguments `up` or `down`
to increase or decrease by 10% the volume and `mute` to mute volume.It displays
through dunst a fancy notification when you execute any of those actions.

If you won't need it, check out the following files to get it out of the
environment:

- `.config/i3/conf.d/bindings.conf` for the related bindings on `i3`.
- `.config/sxkhd/sxkhdrc` same as above, but to work on `bspwm`.
- `.config/i3/conf.d/modes.conf` to delete the mode where you control the volume
  on `i3`.
- `.config/polybar/config.ini` to disable the scrolling functions on the bar
  that are configured to run this script.

### wal_alacritty.sh

This script set the right colors for Alacritty using `pywal`, since this
command doesn't follow the new TOML configuration for that terminal.

It is used only on `set_update_wallpapper.sh` script. If you don't need it,
you just have to delete/comment the line 88 of the script.
