#!/bin/sh

run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run setxkbmap latam
run picom -b -f
run connman-gtk
run parcellite
run redshift-gtk
run udiskie -ants
run dunst
run mpd ~/.config/mpd/mpd.conf
run blueman-applet
# run /usr/bin/emacs --daemon
