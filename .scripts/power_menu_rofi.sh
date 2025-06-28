#!/usr/bin/env bash

dir_theme="$HOME/.config/rofi/themes/power-menu.rasi"
uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)
shutdown=' '
reboot=' '
lock=' '
logout=' '
yes=' '
no=' '

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -p "Host: $host Uptime: $uptime" \
    -mesg "Uptime: $uptime" \
    -theme "${dir_theme}"
}

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you Sure?' \
    -theme "${dir_theme}"
}

# Ask for confirmation
confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    if [[ $1 == '--shutdown' ]]; then
      loginctl poweroff -i
    elif [[ $1 == '--reboot' ]]; then
      loginctl reboot
    elif [[ $1 == '--logout' ]]; then
      bspc quit
    fi
  else
    exit 0
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
"$shutdown")
  run_cmd --shutdown
  ;;
"$reboot")
  run_cmd --reboot
  ;;
"$lock")
  betterlockscreen -l blur
  ;;
"$logout")
  run_cmd --logout
  ;;
esac
