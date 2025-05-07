#!/usr/bin/env bash
set -euo pipefail

STEP=5
ICON="display-brightness-symbolic"
NOTIF_ID=5555

# Get the actual brightness percentage (0-100)
get_brightness() {
  xbacklight -get | cut -d '.' -f1
}

# Send the notifications with dunst
send_notification() {
  local brightness pct
  brightness=$(get_brightness)
  pct=$((brightness / STEP))
  bar=$(printf '█%.0s' $(seq 1 $pct))
  dunstify \
    -i "$ICON" \
    -r "$NOTIF_ID" \
    -u normal \
    "Brightness: $bar $brightness%"
}

# Up/Down brightness
case "${1:-}" in
up)
  xbacklight -inc "$STEP" >/dev/null
  send_notification
  ;;
down)
  xbacklight -dec "$STEP" >/dev/null
  send_notification
  ;;
*)
  echo "Uso: $0 {up|down}" >&2
  exit 1
  ;;
esac
