#!/usr/bin/env bash
set -euo pipefail

LOW_BATTERY_LEVEL=20
BATTERY_PATH="/sys/class/power_supply/BAT1"
CAPACITY_FILE="$BATTERY_PATH/capacity"
STATUS_FILE="$BATTERY_PATH/status"
notify_id=9999

# Verifica existencia de archivos
if [[ ! -f $CAPACITY_FILE || ! -f $STATUS_FILE ]]; then
  echo "No se encontró info de batería en $BATTERY_PATH" >&2
  exit 1
fi

# Devuelve icono según nivel y estado
choose_icon() {
  local lvl=$1 state=$2 icon
  case "$state" in
  Charging)
    if ((lvl <= LOW_BATTERY_LEVEL)); then
      icon="battery-caution-charging-symbolic"
    elif ((lvl <= 40)); then
      icon="battery-low-charging-symbolic"
    elif ((lvl <= 75)); then
      icon="battery-good-charging-symbolic"
    else
      icon="battery-full-charging-symbolic"
    fi
    ;;
  Full)
    icon="battery-full-charged-symbolic"
    ;;
  Discharging)
    if ((lvl <= LOW_BATTERY_LEVEL)); then
      icon="battery-empty-symbolic"
    elif ((lvl <= 40)); then
      icon="battery-low-symbolic"
    elif ((lvl <= 75)); then
      icon="battery-good-symbolic"
    else
      icon="battery-full-symbolic"
    fi
    ;;
  *)
    icon="battery-caution-symbolic"
    ;;
  esac
  printf '%s' "$icon"
}

last_status=""
notified_low=false
notified_full=false

while true; do
  level=$(<"$CAPACITY_FILE")
  status=$(<"$STATUS_FILE")
  icon=$(choose_icon "$level" "$status")

  # Notificaciones únicas para cambios de estado
  if [[ "$status" != "$last_status" ]]; then
    case "$status" in
    Charging)
      dunstify -i "$icon" -r $notify_id -u normal "Cargando" "Nivel: ${level}%"
      ;;
    Full)
      if [[ "$notified_full" == false ]]; then
        dunstify -i "$icon" -r $notify_id -u normal "Batería llena" "100% completa"
        notified_full=true
      fi
      ;;
    esac
    last_status="$status"
  fi

  # Alerta de batería baja
  if [[ "$status" == "Discharging" && "$level" -le LOW_BATTERY_LEVEL && "$notified_low" == false ]]; then
    dunstify -i "$icon" -r $notify_id -u critical "Batería baja" "Queda ${level}% — conecta el cargador"
    notified_low=true
  fi

  # Reinicia la alerta si sube de umbral
  if [[ "$status" == "Discharging" && "$level" -gt LOW_BATTERY_LEVEL ]]; then
    notified_low=false
  fi

  sleep 60
done
