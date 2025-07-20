#!/usr/bin/env bash
set -euo pipefail

get_volume() { pamixer --get-volume; }
is_mute() { pamixer --get-mute | grep -q true; }

send_notification() {
  local icon bar
  if is_mute; then
    icon="audio-volume-muted"
    dunstify -i "$icon" -r 2593 -u normal "Muted"
  else
    local vol
    vol=$(get_volume)
    printf -v bar '%*s' $((vol / 10)) ''
    bar=${bar// /█}
    dunstify -i "audio-volume-high" -r 2593 -u normal "   $bar $vol%"
  fi
}

case "${1:-}" in
up)
  pamixer --unmute
  pamixer -i 10 >/dev/null
  send_notification
  ;;
down)
  pamixer --unmute
  pamixer -d 10 >/dev/null
  send_notification
  ;;
mute)
  pamixer -t >/dev/null
  send_notification
  ;;
*)
  echo "Usage: $0 {up|down|mute}" >&2
  exit 1
  ;;
esac
