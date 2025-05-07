#!/usr/bin/env bash
# Switch Windows with dmenu and wmctrl

set -euo pipefail

# Build menu entries
menu_entries=$(
  wmctrl -l | while read -r winid desk host title_rest; do
    class=$(xdotool getwindowclassname "$winid")
    printf '%s\t%s\n' "$class" "$winid"
  done
)

# Pick selection
selection=$(printf '%s\n' "$menu_entries" | dmenu -i -l 20 -p "Switch to:" || exit 0)

if [ -n "$selection" ]; then
  win_id=${selection##*$'\t'}
  wmctrl -ia "$win_id"
fi
