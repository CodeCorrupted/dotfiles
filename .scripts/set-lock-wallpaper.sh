#!/usr/bin/env bash

set -euo pipefail

# Files to update
I3_AUTOSTART="$HOME/.config/i3/autostart.sh"
I3_BINDS="$HOME/.config/i3/conf.d/bindings.conf"
POWER_MENU="$HOME/.scripts/power-menu.sh"

# Check wm running
check_wm() {
  if pgrep -x i3 >/dev/null; then
    return 0
  elif pgrep -x bspwm >/dev/null; then
    return 1
  else
    return 2
  fi
}

# Update config files
update_config() {
  sed -i -E "s|$2|$3|" "$1"
}

main() {
  # Validate argument
  if [ $# -ne 1 ]; then
    echo "Uso: $0 /path/to/image" >&2
    exit 1
  fi

  # Validate image
  IMG_PATH=$(realpath "$1")
  if [ ! -f "$IMG_PATH" ]; then
    echo "Archivo no encontrado: $IMG_PATH" >&2
    exit 1
  fi

  # Act depending on which wm is running
  set +e
  check_wm
  wm_code=$?
  set -e

  if [[ $wm_code -eq 0 ]]; then
    update_config \
      "$I3_AUTOSTART" \
      'xautolock -detectsleep -time [0-9]+ -locker .+' \
      "xautolock -detectsleep -time 10 -locker \"i3lock --image=${IMG_PATH}\""

    update_config \
      "$I3_BINDS" \
      '(--image=)[^ ]+' \
      "\1${IMG_PATH}"

    update_config \
      "$POWER_MENU" \
      '(--image=)[^ ]+' \
      "\1${IMG_PATH}"

    i3-msg reload

  elif [[ $wm_code -eq 1 ]]; then
    betterlockscreen -u "$IMG_PATH"
  else
    echo "Ni i3 ni bspwm detectados. Abortando." >&2
    exit 1
  fi
}

main "$@"
