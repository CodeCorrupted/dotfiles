#!/bin/bash

# Verificar si se proporciona un fondo de pantalla
if [ -z "$1" ]; then
  echo "Uso: $0 /ruta/a/fondo.jpg"
  exit 1
fi

# Cambiar el fondo con feh
feh --bg-scale "$1"

# Actualizar los colores en i3wm
~/.scripts/update-i3-colors.sh "$1"
