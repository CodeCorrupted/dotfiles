#!/usr/bin/env bash
OUTFILE="/tmp/brightness"
BL_DIR="/sys/class/backlight"

mapfile -t dirs < <(printf '%s\n' "$BL_DIR"/*)
[[ ${#dirs[@]} -eq 0 ]] && exit 1

dev=${dirs[0]}

get() {
  local cur max
  cur=$(<"$dev/brightness")
  max=$(<"$dev/max_brightness")
  printf '%d%%' "$((cur * 100 / max))"
}

# initial
get >"$OUTFILE"

# wait for changes
while inotifywait -e modify "$dev/brightness" >/dev/null 2>&1; do
  get >"$OUTFILE"
done
