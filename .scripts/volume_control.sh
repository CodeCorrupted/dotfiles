#!/usr/bin/env bash
set -euo pipefail

# Get the actual volume percentage (0-100)
get_volume() {
  pamixer --get-volume
}

# Check if its muted
is_mute() {
  pamixer --get-mute | grep -q true
}

# Notify the volume change
send_notification() {
  local iconSound="audio-volume-high"
  local iconMuted="audio-volume-muted"

  if is_mute; then
    dunstify -i "$iconMuted" -r 2593 -u normal "Muted"
  else
    local volume bar
    volume=$(get_volume)
    bar=$(printf '█%.0s' $(seq 1 $((volume / 10))))
    dunstify -i "$iconSound" -r 2593 -u normal "    $bar"
  fi
}

case "${1:-}" in
up)
  pamixer --unmute
  pamixer --increase 10 >/dev/null
  send_notification
  ;;

down)
  pamixer --unmute
  pamixer --decrease 10 >/dev/null
  send_notification
  ;;

mute)
  pamixer --toggle-mute >/dev/null
  send_notification
  ;;

*)
  echo "Usage: $0 {up|down|mute}" >&2
  exit 1
  ;;
esac
