#!/usr/bin/env bash
set -euo pipefail

# Paths
I3_CONFIG="$HOME/.config/i3/conf.d/windows_display.conf"
I3_BARCONF="$HOME/.config/i3/conf.d/bar.conf"
DMENU_CONF="$HOME/.config/i3/conf.d/bindings.conf"
DMENU_POWERMENU="$HOME/.scripts/power-menu.sh"
DUNST_CONF_I3="$HOME/.config/dunst/dunstrc-i3"
DUNST_CONF_BSPWM="$HOME/.config/dunst/dunstrc-bspwm"
POLYBAR_COLORS="$HOME/.config/polybar/colors.ini"
BSPWM_AUTOSTART="$HOME/.config/bspwm/autostart.sh"
ROFI_COLORS="$HOME/.config/rofi/colors/theme-pywal.rasi"

# Function to replace values with sed
# args: <file> <pattern> <replacement>
update_config() {
  local file="$1" pattern="$2" replacement="$3"
  sed -i -E "s|${pattern}|${replacement}|" "${file}"
}

# Detect window manager
detect_wm() {
  if pgrep -x i3 >/dev/null; then
    echo i3
  elif pgrep -x bspwm >/dev/null; then
    echo bspwm
  else
    echo none
  fi
}

apply_wallpapper() {
  local img="$1" wm="$2"
  if [[ $wm == "i3" ]]; then
    feh --bg-scale "$img"
  elif [[ $wm == "bspwm" ]]; then
    update_config "$BSPWM_AUTOSTART" '^xwallpaper .+' "xwallpaper --zoom '${img}'"
    xwallpaper --zoom "${img}"
  fi
}

# Generate and parse pywal colors
generate_palette() {
  wal -i "$1" -n
  local cache="$HOME/.cache/wal/colors"
  BG=$(sed -n '1p' "$cache")
  FG=$(sed -n '16p' "$cache")
  ACC1=$(sed -n '4p' "$cache")
  ACC2=$(sed -n '10p' "$cache")
  ACC3=$(sed -n '8p' "$cache")
  ACC4=$(sed -n '5p' "$cache")
  RED=$(sed -n '2p' "$cache")
  ALERT=$(sed -n '3p' "$cache")
}

# Update colors based on wm
update_colors() {
  local wm="$1"
  if [[ $wm == "i3" ]]; then
    #i3 colors
    update_config "$I3_CONFIG" "^set \$bg .+" "set \$bg ${BG}"
    update_config "$I3_CONFIG" "^set \$fg .+" "set \$fg ${FG}"
    update_config "$I3_CONFIG" "^set \$in .+" "set \$in ${ACC2}"
    # i3bar
    update_config "$I3_BARCONF" "^[[:space:]]*set[[:space:]]+\\\$fg_bar[[:space:]]+.*" "set \$fg_bar $FG"
    update_config "$I3_BARCONF" "^[[:space:]]*set[[:space:]]+\\\$bg_bar[[:space:]]+.*" "set \$bg_bar $BG"
    update_config "$I3_BARCONF" "^[[:space:]]*set[[:space:]]+\\\$fw[[:space:]]+.*" "set \$fw     $ACC1"
    update_config "$I3_BARCONF" "^[[:space:]]*set[[:space:]]+\\\$aw[[:space:]]+.*" "set \$aw     $ACC2"
    update_config "$I3_BARCONF" "^[[:space:]]*set[[:space:]]+\\\$iw[[:space:]]+.*" "set \$iw     $ACC4"
    update_config "$I3_BARCONF" "^[[:space:]]*set[[:space:]]+\\\$uw[[:space:]]+.*" "set \$uw     $RED"
    # dmenu
    update_config "$DMENU_CONF" "(--dmenu='dmenu)[^']+'" "\1 -i -b -fn 'Hurmit Nerd Font' -nb ${BG} -nf ${FG} -sb ${ACC1} -sf ${ACC3}'"
    update_config "$DMENU_CONF" "dmenu_run .+" "dmenu_run -b -fn 'Hurmit Nerd Font' -nb '${BG}' -nf '${FG}' -sb '${ACC1}' -sf '${ACC3}'\""
    # power-menu
    update_config "$DMENU_POWERMENU" "^[[:space:]]*dmenu -i .+" "  dmenu -i -l 4 -p \"Power Menu: \" -fn 'Hurmit Nerd Font' -nb '${BG}' -nf '${FG}' -sb '${ACC1}' -sf '${ACC3}'"
    # dunst
    update_config "$DUNST_CONF_I3" "^[[:space:]]*background[[:space:]]*= .*" "    background = \"${BG}\""
    update_config "$DUNST_CONF_I3" "^[[:space:]]*foreground[[:space:]]*= .*" "    foreground = \"${FG}\""
    update_config "$DUNST_CONF_I3" "^[[:space:]]*frame_color[[:space:]]*= .*" "    frame_color = \"${ACC2}\""
    # kitty
    cp ~/.cache/wal/colors-kitty.conf ~/.config/kitty/kitty.d/colors-kitty.conf
    # reload i3
    i3-msg reload
    i3-msg restart
  elif [[ $wm == "bspwm" ]]; then
    # alacritty
    wal_alacritty.sh ~/.config/alacritty/colors.toml
    # rofi
    update_config "$ROFI_COLORS" "^[[:space:]]*background[[:space:]]*= .*" "    background: ${BG};"
    update_config "$ROFI_COLORS" "^[[:space:]]*background-alt[[:space:]]*= .*" "    background-alt: ${ACC3};"
    update_config "$ROFI_COLORS" "^[[:space:]]*foreground[[:space:]]*= .*" "    foreground: ${FG};"
    update_config "$ROFI_COLORS" "^[[:space:]]*selected[[:space:]]*= .*" "    selected: ${ACC1};"
    update_config "$ROFI_COLORS" "^[[:space:]]*active[[:space:]]*= .*" "    active: ${ACC2};"
    update_config "$ROFI_COLORS" "^[[:space:]]*urgent[[:space:]]*= .*" "    urgent: ${ALERT};"
    # polybar
    update_config "$POLYBAR_COLORS" '^bg-modules = .*' "bg-modules = ${BG}"
    update_config "$POLYBAR_COLORS" '^fg = .*' "fg = ${FG}"
    update_config "$POLYBAR_COLORS" '^active = .*' "active = ${ACC1}"
    update_config "$POLYBAR_COLORS" '^underline = .*' "underline = ${ACC3}"
    update_config "$POLYBAR_COLORS" '^alert = .*' "alert = ${RED}"
    update_config "$POLYBAR_COLORS" '^urgent = .*' "urgent = ${ALERT}"
    update_config "$POLYBAR_COLORS" '^buttons-mpd = .*' "buttons-mpd = ${ALERT}"
    update_config "$POLYBAR_COLORS" '^memory = .*' "memory = ${ACC1}"
    update_config "$POLYBAR_COLORS" '^bright = .*' "bright = ${ACC2}"
    update_config "$POLYBAR_COLORS" '^audio = .*' "audio = ${ACC3}"
    update_config "$POLYBAR_COLORS" '^date = .*' "date = ${ACC4}"
    update_config "$POLYBAR_COLORS" '^battery = .*' "battery = ${RED}"
    # restart polybar
    polybar-msg cmd restart &>/dev/null
    # dunst
    update_config "$DUNST_CONF_BSPWM" "^[[:space:]]*background[[:space:]]*= .*" "    background = \"${BG}\""
    update_config "$DUNST_CONF_BSPWM" "^[[:space:]]*foreground[[:space:]]*= .*" "    foreground = \"${FG}\""
    update_config "$DUNST_CONF_BSPWM" "^[[:space:]]*frame_color[[:space:]]*= .*" "    frame_color = \"${ACC2}\""
  fi

  # restart dunst
  pkill dunst
  dunst &
}

main() {
  if [[ $# -ne 1 ]]; then
    echo "Usage: $0 /path/to/image" >&2
  fi
  local img
  img=$(realpath "$1")
  [[ -f "$img" ]] || {
    echo "File not found: $img" >&2
    exit 1
  }
  local wm
  wm=$(detect_wm)
  [[ $wm != none ]] || {
    echo "No supported wm detected." >&2
    exit 1
  }

  apply_wallpapper "$img" "$wm"
  generate_palette "$img"
  update_colors "$wm"
}

main "$@"
