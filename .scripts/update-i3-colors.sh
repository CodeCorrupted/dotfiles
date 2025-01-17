#!/bin/bash

# Ruta al fondo de pantalla
WALLPAPER="$1"

# Ruta al archivo de configuración de i3
I3_CONFIG="$HOME/.config/i3/conf.d/windows_display.conf"

# Verificar si se proporciona un fondo de pantalla
if [ -z "$WALLPAPER" ]; then
  echo "Uso: $0 /ruta/a/fondo-de-pantalla.jpg"
  exit 1
fi

# Generar esquema de colores con pywal
wal -i "$WALLPAPER" -n

# Extraer colores principales de pywal
FG=$(cat ~/.cache/wal/colors | sed -n '1p') # Color 1: Foreground
BG=$(cat ~/.cache/wal/colors | sed -n '2p') # Color 2: Background
IN=$(cat ~/.cache/wal/colors | sed -n '5p') # Color 5: Indicator

# Actualizar colores en la configuración de i3
sed -i "s/^set \$fg .*/set \$fg $FG/" "$I3_CONFIG"
sed -i "s/^set \$bg .*/set \$bg $BG/" "$I3_CONFIG"
sed -i "s/^set \$in .*/set \$in $IN/" "$I3_CONFIG"

# Recargar i3 para aplicar los cambios
i3-msg reload
i3-msg restart

echo "Colores actualizados: fg=$FG, bg=$BG, in=$IN"
