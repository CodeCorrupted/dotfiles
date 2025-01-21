#!/bin/bash

# Ruta al fondo de pantalla
WALLPAPER="$1"

# Ruta al archivo de configuración de i3
I3_CONFIG="$HOME/.config/i3/conf.d/windows_display.conf"
ROFI_THEME="$HOME/.config/rofi/colors/theme-pywal.rasi"
DUNST_CONFIG="$HOME/.config/dunst/dunstrc"
POLYBAR_COLORS="$HOME/.config/polybar/colors.ini"

# Verificar si se proporciona un fondo de pantalla
if [ -z "$WALLPAPER" ]; then
  echo "Uso: $0 /ruta/a/fondo-de-pantalla.jpg"
  exit 1
fi

# Generar esquema de colores con pywal
wal -i "$WALLPAPER" -n

# Cambiar a la ruta completa del wallpaper
WALLPAPER=$(realpath "$1")
WALLPAPER="${WALLPAPER/$HOME/\$HOME}"

# Función para verificar si un color es claro u oscuro
is_light() {
  local color="$1"

  # Validar que la entrada sea un color hexadecimal válido
  if [[ ! "$color" =~ ^#[0-9A-Fa-f]{6}$ ]]; then
    echo "false"
    return
  fi

  # Extraer componentes RGB del color
  local r g b luminance
  r=$(printf "%d" 0x${color:1:2})
  g=$(printf "%d" 0x${color:3:2})
  b=$(printf "%d" 0x${color:5:2})

  # Calcular luminancia relativa
  luminance=$(((r * 299 + g * 587 + b * 114) / 1000))

  # Devolver true si es un color claro, false si es oscuro
  [[ $luminance -gt 127 ]] && echo "true" || echo "false"
}

# Extraer colores principales de pywal
BG=$(cat ~/.cache/wal/colors | sed -n '1p')       # Color oscuro
FG=$(cat ~/.cache/wal/colors | sed -n '16p')      # Color claro
ACCENT1=$(cat ~/.cache/wal/colors | sed -n '4p')  # Color 1
ACCENT2=$(cat ~/.cache/wal/colors | sed -n '10p') # Color 2
ACCENT3=$(cat ~/.cache/wal/colors | sed -n '8p')  # Color 3
ACCENT4=$(cat ~/.cache/wal/colors | sed -n '7p')  # Color 4
RED=$(cat ~/.cache/wal/colors | sed -n '2p')      # Color rojo (o cercano)

# Forzar `bg-modules` a un color oscuro
if [[ $(is_light "$BG") == "true" ]]; then
  BG="#88000000" # Sobrescribir con un color oscuro
fi

# Asegurar que `fg` sea claro
if [[ $(is_light "$FG") == "false" ]]; then
  FG="#EAEDF1" # Sobrescribir con un color claro
fi

# Asegurar que `alert` sea un color rojo
ALERT="$RED"

# Asegurar que `urgent` contraste con `alert` (gris oscuro)
URGENT="#343434"

# Configurar el resto de los colores con contrastes
ACTIVE="$ACCENT1"
UNDERLINE="$ACCENT3"
I3="$ACCENT1"
MPD="$ACCENT2"
MEMORY="$ACCENT3"
BRIGHT="$ACCENT4"
AUDIO="$ACCENT1"
DATE="$ACCENT2"
BATTERY="$ACCENT3"

# Actualizar colores en la configuración de i3
sed -i "s/^set \$fg .*/set \$fg $FG/" "$I3_CONFIG"
sed -i "s/^set \$bg .*/set \$bg $BG/" "$I3_CONFIG"
sed -i "s/^set \$in .*/set \$in $ACCENT2/" "$I3_CONFIG"

# Actualizar colores en el tema de Rofi
sed -i "s/^    background: .*/    background:    $BG;/" "$ROFI_THEME"
sed -i "s/^    foreground: .*/    foreground:    $FG;/" "$ROFI_THEME"
sed -i "s/^    selected: .*/    selected:      $ACCENT4;/" "$ROFI_THEME"
sed -i "s/^    border-color: .*/    border-color:  $ACCENT2;/" "$ROFI_THEME"

# Actualizar colores en Dunst
sed -i "s/^    background = .*/    background = \"$BG\";/" "$DUNST_CONFIG"
sed -i "s/^    foreground = .*/    foreground = \"$FG\";/" "$DUNST_CONFIG"
sed -i "s/^    frame_color = .*/    frame_color = \"$ACCENT2\";/" "$DUNST_CONFIG"

# Actualizar colores de Polybar
sed -i "s/^fg = .*/fg = $FG/" "$POLYBAR_COLORS"
sed -i "s/^bg-modules = .*/bg-modules = $BG/" "$POLYBAR_COLORS"
sed -i "s/^buttons-mpd = .*/buttons-mpd = $MPD/" "$POLYBAR_COLORS"
sed -i "s/^bg-i3 = .*/bg-i3 = $I3/" "$POLYBAR_COLORS"
sed -i "s/^active = .*/active = $ACTIVE/" "$POLYBAR_COLORS"
sed -i "s/^underline = .*/underline = $UNDERLINE/" "$POLYBAR_COLORS"
sed -i "s/^alert = .*/alert = $ALERT/" "$POLYBAR_COLORS"
sed -i "s/^urgent = .*/urgent = $URGENT/" "$POLYBAR_COLORS"
sed -i "s/^memory = .*/memory = $MEMORY/" "$POLYBAR_COLORS"
sed -i "s/^bright = .*/bright = $BRIGHT/" "$POLYBAR_COLORS"
sed -i "s/^audio = .*/audio = $AUDIO/" "$POLYBAR_COLORS"
sed -i "s/^date = .*/date = $DATE/" "$POLYBAR_COLORS"
sed -i "s/^battery = .*/battery = $BATTERY/" "$POLYBAR_COLORS"

# Recargar i3 para aplicar los cambios
i3-msg reload
i3-msg restart
# Recargar Dunst para aplicar los cambios
pkill dunst
dunst &
# Reiniciar polybar
polybar-msg cmd restart
