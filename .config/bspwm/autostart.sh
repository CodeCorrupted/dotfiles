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

# Set the wallpapper for bspwm
xwallpaper --zoom '/home/arc/Images/Wallpapers/2256.jpg'

# Run polybar
run ~/.config/polybar/launch.sh

# Start picom as daemon
run picom -b

# Start applet of network manager connman
run connman-gtk

# Start redshift, a program to control the temperature of your screen
run redshift-gtk

# Start the icon of an automonter of removable media
run udiskie -as

# Start a notification daemon
run dunst -conf "$HOME/.config/dunst/dunstrc-bspwm"

# Start mpd with its config file
run mpd ~/.config/mpd/mpd.conf

# Start bluetooth applet
run blueman-applet

# Start script to check battery charge. Commment if you don't use a laptop
run ~/.scripts/battery_check.sh

# Start process to detect inactivity and lock screen after 10 minutes
run xautolock -detectsleep -time 10 -locker "betterlockscreen -l blur"

# Fix to run java applications
wmname LG3D
