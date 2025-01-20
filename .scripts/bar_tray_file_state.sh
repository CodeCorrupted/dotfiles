#!/usr/bin/env bash

# Nombre de la barra
BAR_NAME="bar-tray"
STATE_FILE="/tmp/polybar_${BAR_NAME}_state"

# Leer el estado actual
if [[ -f "$STATE_FILE" && "$(cat $STATE_FILE)" == "open" ]]; then
  # Si está abierta, cerrarla
  pkill -f "polybar $BAR_NAME"
  echo "closed" >"$STATE_FILE"
else
  # Si está cerrada, abrirla
  echo "---" | tee -a /tmp/polybar2.log
  polybar "$BAR_NAME" >>/tmp/polybar2.log 2>&1 &
  echo "open" >"$STATE_FILE"
fi
