#!/usr/bin/env bash

OUTFILE="/tmp/brightness"
INTERVAL=5

while true; do
  pct=$(xbacklight -get | xargs printf "%d%%")
  printf "%s\n" "$pct" >"$OUTFILE"
  sleep "$INTERVAL"
done
