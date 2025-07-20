#!/usr/bin/env bash
set -euo pipefail

menu=$(
  wmctrl -l | while read -r id _ _ title; do
    cls=$(xprop -id "$id" WM_CLASS | sed 's/.*"\([^"]*\)".*/\1/')
    printf '%s\t%s\n' "${cls:-Unknown}" "$id"
  done
)
sel=$(printf '%s\n' "$menu" | dmenu -i -l 20 -p "Switch to:" || exit 0)
[[ -n $sel ]] && wmctrl -ia "${sel##*$'\t'}"
