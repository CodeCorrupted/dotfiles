#!/usr/bin/env bash
set -euo pipefail

LOW=20
ID=9999

# find first battery
BAT=$(printf '%s\n' /sys/class/power_supply/BAT* | head -n1)
[[ -n $BAT ]] || {
  echo "No battery found" >&2
  exit 1
}

get() { printf '%s\n' "$(<"$BAT/capacity")"; }
stat() { printf '%s\n' "$(<"$BAT/status")"; }

choose_icon() {
  local lvl=$1 st=$2
  case $st in
  Charging) icon="battery-caution-charging-symbolic" ;;
  Full) icon="battery-full-charged-symbolic" ;;
  *) icon="battery-empty-symbolic" ;;
  esac
  printf '%s\n' "$icon"
}

last_st=
low_sent=false
while true; do
  lvl=$(get)
  st=$(stat)
  icon=$(choose_icon "$lvl" "$st")

  [[ $st != "$last_st" ]] && {
    dunstify -i "$icon" -r "$ID" -u normal "$st" "${lvl}%"
    last_st=$st
  }

  [[ $st == Discharging && $lvl -le $LOW && $low_sent == false ]] && {
    dunstify -i "$icon" -r "$ID" -u critical "Low battery" "${lvl}% remaining"
    low_sent=true
  }

  [[ $st != Discharging || $lvl -gt $LOW ]] && low_sent=false
  sleep 60
done
