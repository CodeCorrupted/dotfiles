#!/bin/bash

# Ruta al fondo de pantalla
WALLPAPER="$1"

# Ruta al archivo de configuración de i3
I3_CONFIG="$HOME/.config/i3/conf.d/windows_display.conf"
ROFI_THEME="$HOME/.config/rofi/colors/theme-pywal.rasi"

# Verificar si se proporciona un fondo de pantalla
if [ -z "$WALLPAPER" ]; then
  echo "Uso: $0 /ruta/a/fondo-de-pantalla.jpg"
  exit 1
fi

# Generar esquema de colores con pywal
wal -i "$WALLPAPER" -n

# Extraer colores principales de pywal
FG=$(cat ~/.cache/wal/colors | sed -n '15p')    # Color 1: Foreground
BG=$(cat ~/.cache/wal/colors | sed -n '1p')     # Color 2: Background
IN=$(cat ~/.cache/wal/colors | sed -n '5p')     # Color 5: Indicator
BORDER=$(cat ~/.cache/wal/colors | sed -n '2p') # Color 8: Border

# Actualizar colores en la configuración de i3
sed -i "s/^set \$fg .*/set \$fg $FG/" "$I3_CONFIG"
sed -i "s/^set \$bg .*/set \$bg $BG/" "$I3_CONFIG"
sed -i "s/^set \$in .*/set \$in $IN/" "$I3_CONFIG"

# Actualizar colores en el tema de Rofi
sed -i "s/^    background: .*/    background:    $BG;/" "$ROFI_THEME"
sed -i "s/^    foreground: .*/    foreground:    $FG;/" "$ROFI_THEME"
sed -i "s/^    selected: .*/    selected:      $IN;/" "$ROFI_THEME"
sed -i "s/^    border-color: .*/    border-color:  $BORDER;/" "$ROFI_THEME"

# Recargar i3 para aplicar los cambios
i3-msg reload
i3-msg restart

echo "Colores actualizados: fg=$FG, bg=$BG, in=$IN, border=$BORDER"
