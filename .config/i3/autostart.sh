#!/bin/sh

# This function only executes a program if it's not already running
run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

# Set keyboard layout to es-latam
run setxkbmap latam

# Start picom as daemon
run picom -b

# Start applet of network manager connman
run connman-gtk

# Start parcellite, a clipboard manager
run parcellite

# Start redshift, a program to control the temperature of your screen
run redshift-gtk

# Start the icon of an automonter of removable media
run udiskie -as

# Start a notification daemon
run dunst

# Start mpd with its config file
run mpd ~/.config/mpd/mpd.conf

# Set wallpapper
run ~/.fehbg

# Start bluetooth applet
run blueman-applet
