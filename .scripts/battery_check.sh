#!/bin/bash

# Nivel mínimo antes de la notificación
LOW_BATTERY_LEVEL=20

# Rutas de la información de la batería (ajústalas si es necesario)
BATTERY_PATH="/sys/class/power_supply/BAT1"
CAPACITY_FILE="$BATTERY_PATH/capacity"
STATUS_FILE="$BATTERY_PATH/status"

# Verificar si los archivos existen
if [[ ! -f $CAPACITY_FILE || ! -f $STATUS_FILE ]]; then
  echo "No se encontró la información de la batería en $BATTERY_PATH"
  exit 1
fi

while true; do
  # Obtener nivel de batería y estado (Cargando o Descargando)
  BATTERY_LEVEL=$(cat "$CAPACITY_FILE")
  STATUS=$(cat "$STATUS_FILE")

  # Si la batería está baja y no se está cargando, envía la notificación
  if [[ "$BATTERY_LEVEL" -le $LOW_BATTERY_LEVEL && "$STATUS" != "Charging" ]]; then
    notify-send -u critical "⚠️ Batería baja" "Quedan $BATTERY_LEVEL% de batería. Conecta el cargador."
  fi

  # Verificar cada 5 minutos
  sleep 300
done
