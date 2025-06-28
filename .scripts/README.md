# Scripts

This folder contains scripts to improve or automatize tasks on my environment.
Each one of them run as a background process or run under certain conditions
(like a keyboard shortcut).

This file will explain what tasks do every script in this folder, so you can
decide which are is usefull for you and which are useless.

## bar_tray_file_state.sh

This script runs a second instance of polybar which only shows a tray icon module.

If you don't need this, you should check the configuration of polybar and
delete/comment modules-right section on the config.ini file (the text that
includes the arrow-tray module) and, optionally, delete the
`.config/polybar/bar-tray.ini` and `.config/polybar/modules/arrow-tray.ini`
files.

## battery_check.sh

This script runs as a background process, started by the autostart.sh of each
window manager here (i3 and bspwm).

This script sends a notification through dunst to show you if the battery is:

- Charging
- With low battery (20%)
- Full battery

It executes once each minute. You can give it a shorter time to refresh
editting the line 88 (in seconds). Also, you have to edit the variables:

- BATTERY_PATH: to use your path to the battery on your computer.
- LOW_BATTERY_LEVEL (optional): to set the level that you think is low enough
  to show the notification.

If you don't need this script, before delete it be sure to edit the autostart.sh
file of bspwm and/or i3 and comment/delete the line that runs this script and
you'll be good to go.

## bright_status.sh

This script runs at start i3. It shows the bright level on the i3-bar. It uses
the xbacklight command and executes on an interval of 5 seconds. If you don't
need it, delete/comment the line that launch this script on the autostart.sh of
i3, and edit the configuration file on i3status directory, the section which
displays the bright.

## brightness_control.sh

This one runs when you press the keys to increase brightness of your screen
(only set up for laptops). It shows a notification through dunst, increasing
or decreasing at interval of 5 percent. It uses xbacklight command.

If you won't need it, please edit the files `.config/i3/conf.d/bindings.conf`,
`.config/i3/conf.d/modes.conf` and `.config/sxkhd/sxkhdrc` to comment
those bindings related to the script.

## dmenu_window.sh

This script displays dmenu with options to switch between the windows of
applications currently open on your system. This is used only on i3.

If you won't need it, just edit the `.config/i3/conf.d/bindings.conf` file
to delete/comment the related binding.

## label-mpd.py

This is used by polybar to display the name of the song and artist from the
playlist of mpd. I used python because it's better at displaying text and
uses less resources. You must have the `mpc` command available.

If you won't use it, edit the `.config/polybar/config.ini` file to comment
the middle module of mpd-label, and delete the
`.config/polybar/modules/mpd-label.ini` file.

## power_menu_rofi.sh

This script launches a power menu using rofi. It depends on a config file
for the theme it uses on `.config/rofi/themes/power-menu.rasi`, rofi
and a patched font (Nerd Font).

If you don't need it, you can delete it and edit the `.config/sxkhd/sxkhdrc`
to delete the keyboard shortcut and `.config/polybar/config.ini` and
`.config/polybar/modules/power-button.ini` to get it out of the bar.

## power_menu_dmenu.sh

This script launches a power menu using dmenu. You must have dmenu and a patched
font installed (Nerd Font).

If you don't need it, edit the `.config/i3/conf.d/bindings.conf` file to delete
or comment the related binding.

## set_lock_wallpapper.sh

This one I use it to change the lock wallpapper. On bspwm, it uses the
betterlockscreen commmand, and on i3 uses i3-lock, so these files are modified
when you run the script under i3: `.config/i3/autostart.sh`,
`.config/i3/conf.d/bindings.conf` and `.scripts/power_menu_dmenu.sh`.

This script is super usefull and, if you use my `.zshrc` file, it has an alias
for this script. Anyways, if you don't need it, comment/delete the alias on
`.zshrc`.

## set_update_wallpapper.sh

This is used to change the wallpapper on bspwm/i3 and make it persistent. To do
that, after run pywal to get a pellete, it edits the following files:

If it runs under i3:

- `.config/i3/conf.d/windows_display.conf` to modify the windows border color.
- `.config/i3/conf.d/bar.conf` to modify bar's colors.
- `.config/i3/conf.d/bindings.conf` to modify dmenu's colors.
- `.scripts/power_menu_dmenu.sh` to modify the power menu colors.
- `.config/dunst/dunstrc-i3` to modify the colors of dunst.
- `.config/kitty/kitty.d/colors-kitty.conf` to change the colors for Kitty
  terminal.

If it runs under bspwm:

- `.config/dunst/dunstrc-bspwm` to modify the colors of dunst.
- `.config/polybar/colors.ini` to modify the colors of polybar.
- `.config/bspwm/autostart.sh` to set the wallpapper and make it persistent.
- `.config/rofi/colors/theme-pywal.rasi` to change the colors of rofi.
- `.config/alacritty/colors.toml` to change the colors of Alacritty.

Besides pywal, the script uses feh, xwallpapper and the wal_alacritty.sh script.

If you won't need this script, just need to delete/comment the alias on `.zshrc`
for this script.

## volume_control.sh

This script uses pulseaudio (the command pamixer) to control the volume of the
system. It displays through dunst a fancy notification when you increase,
decrease or mute the volume.

If you won't need it, check out the following files to get it out of the
environment:

- `.config/i3/conf.d/bindings.conf` for the binding on laptops related to volume
  management.
- `.config/i3/conf.d/modes.conf` same as above.
- `.config/sxkhd/sxkhdrc` same as above, but to work on bspwm.
- `.config/polybar/config.ini` to disable the scrolling functions on the bar
  that are configured to run this script.

## wal_alacritty.sh

The only purpose for this script to exist is to change the colors of Alacritty
on bspwm when you run the `set_update_wallpapper.sh` script. It's not completely
mine, I just modified the script of `egeesin` a little bit. Ty egeesin, btw.

If you don't use this terminal, you just have to delete/comment the line 88 of
the `set_update_wallpapper.sh` script.
