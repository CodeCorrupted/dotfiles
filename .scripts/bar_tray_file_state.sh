#!/usr/bin/env bash

BAR_NAME="bar-tray"
PID_FILE="/tmp/polybar_${BAR_NAME}.pid"
LOG_FILE="/tmp/polybar_${BAR_NAME}.log"

start_bar() {
  [[ $(stat -c%s "$LOG_FILE" 2>/dev/null || echo 0) -gt 1048576 ]] && mv "$LOG_FILE"{,.old}
  echo "---" | tee -a "$LOG_FILE"
  polybar "$BAR_NAME" >>"$LOG_FILE" 2>&1 &
  echo $! >"$PID_FILE"
}

stop_bar() {
  local pid
  pid=$(<"$PID_FILE")
  if kill -0 "$pid" 2>/dev/null; then
    kill "$pid"
    while kill -0 "$pid" 2>/dev/null; do sleep 0.1; done
  fi
  rm -f "$PID_FILE"
}

if [[ -f $PID_FILE ]]; then
  pid=$(<"$PID_FILE")
  if kill -0 "$pid" 2>/dev/null; then
    stop_bar
    exit 0
  fi
fi

start_bar
