#!/bin/bash

wid="$1"
class="$2"

# Fast exit for windows already known
case "$class" in
mGBA | Citra | PPSSPPQt | m64py | dolphin-emu | Connman-gtk | Blueman-manager | Snes9x-gtk | gnome-calculator | SimpleScreenRecorder)
  exit 0
  ;;
esac

# Make it non-case sensitive parsing everything to lowercase
role=$(xprop -id "$wid" WM_WINDOW_ROLE 2>/dev/null | awk -F '"' '{print $2}' | tr '[:upper:]' '[:lower:]')
if [[ -n "$role" ]] && [[ "$role" =~ ^(about|organizer|preferences|task_dialog|toolbox|webconsole)$ ]]; then
  echo "state=floating"
  exit 0
fi

wtype=$(xprop -id "$wid" _NET_WM_WINDOW_TYPE 2>/dev/null | awk -F '"' '{print $2}')
if [[ -z "$wtype" ]]; then
  wtype=$(xprop -id "$wid" WM_WINDOW_TYPE 2>/dev/null | awk -F '"' '{print $2}')
fi

if [[ -n "$wtype" ]]; then
  wtype_lower=$(echo "$wtype" | tr '[:upper:]' '[:lower:]')
  if [[ "$wtype_lower" =~ (dialog|menu|splash|utility|dropdown_menu|popup_menu|toolbar|notification) ]]; then
    echo "state=floating"
    exit 0
  fi
fi

exit 0
