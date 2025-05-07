#!/usr/bin/env bash

# Path to rofi
ROFI="rofi -dmenu -i -p Wi-Fi:"

# scan available networks
connmanctl scan wifi

# List SSID's and show only their names
services=$(connmanctl services | awk '/wifi_[0-9]+/ {print $2}')

# Show the menu and connect
choice=$(printf '%s\n' "$services" | eval "$ROFI")
if [[ -n "$choice" ]]; then
  connmanctl connect "$choice"
fi
