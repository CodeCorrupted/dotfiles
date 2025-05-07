#!/usr/bin/env bash

BAR_NAME="bar-tray"
STATE_FILE="/tmp/polybar_${BAR_NAME}_state"

# Read actual state
if [[ -f "$STATE_FILE" && "$(cat $STATE_FILE)" == "open" ]]; then
  # If its open, close it
  pkill -f "polybar $BAR_NAME"
  echo "closed" >"$STATE_FILE"
else
  # if its closed, open it
  echo "---" | tee -a /tmp/polybar2.log
  polybar "$BAR_NAME" >>/tmp/polybar2.log 2>&1 &
  echo "open" >"$STATE_FILE"
fi
