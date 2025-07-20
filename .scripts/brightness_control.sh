#!/usr/bin/env bash
set -euo pipefail

STEP=5
ID=5555
ICON="display-brightness-symbolic"

# Detect if the system is using light or xbacklight
if command -v light >/dev/null 2>&1; then
  BL_CTL="light"
  UP_OPT=("-A" "$STEP")
  DN_OPT=("-U" "$STEP")
elif command -v xbacklight >/dev/null 2>&1; then
  BL_CTL="xbacklight"
  UP_OPT=("-inc" "$STEP")
  DN_OPT=("-dec" "$STEP")
else
  echo "No backlight tool found (install 'light' or 'xbacklight')" >&2
  exit 1
fi

get_pct() {
  case "$BL_CTL" in
  light) light -G | cut -d'.' -f1 ;;
  xbacklight) xbacklight -get | cut -d'.' -f1 ;;
  esac
}

send_notification() {
  local pct bar
  pct=$(get_pct)
  printf -v bar '%*s' $((pct / STEP)) ''
  bar=${bar// /█}
  dunstify -i "$ICON" -r "$ID" -u normal "Brightness: $bar $pct%"
}

case "${1:-}" in
up)
  "$BL_CTL" "${UP_OPT[@]}" >/dev/null
  send_notification
  ;;
down)
  "$BL_CTL" "${DN_OPT[@]}" >/dev/null
  send_notification
  ;;
*)
  echo "Usage: $0 {up|down}" >&2
  exit 1
  ;;
esac
