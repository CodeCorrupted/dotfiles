#!/bin/bash

LOW_BATTERY_LEVEL=20

while true; do
  BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT*/capacity)
  STATUS=$(cat /sys/class/power_supply/BAT*/status)

  if [[ "$BATTERY_LEVEL" -le $LOW_BATTERY_LEVEL && "$STATUS" != "Charging" ]]; then
    notify-send "⚠️ Batería baja" "Nivel de batería: $BATTERY_LEVEL%" -u critical
  fi
  sleep 300 # Verifica cada 5 minutos
done
