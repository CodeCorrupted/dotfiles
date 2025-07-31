#!/bin/sh

# This function only executes a program if it's not already running
run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

# Set keyboard layout to es-latam & us, and change between them with alt+shift
setxkbmap latam,us
setxkbmap -option 'grp:alt_shift_toggle'

# Start picom as daemon
run picom -b

# Start applet of network manager connman
run connman-gtk

# Start redshift, a program to control the temperature of your screen
run redshift-gtk

# Start the icon of an automonter of removable media
run udiskie -as

# Start a notification daemon
run dunst -conf "$HOME/.config/dunst/dunstrc-i3"

# Start mpd with its config file
run mpd ~/.config/mpd/mpd.conf

# Set wallpapper
run ~/.fehbg

# Start bluetooth applet
run blueman-applet

# Start process to detect inactivity and lock screen after 10 minutes
run xautolock -detectsleep -time 10 -locker "i3lock --image=/home/arc/Images/LockScreen/illust_121045114_20240801_170320.png"

# Start script to check battery charge. Commment if you don't use a laptop
run ~/.scripts/battery_check.sh

# Start script to chek bright level
run ~/.scripts/bright_status.sh
