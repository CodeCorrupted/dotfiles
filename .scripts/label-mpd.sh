#!/bin/bash

# Obtener título y artista de MPD
current=$(mpc current -f "%title% - %artist%")

# Configurar desplazamiento
max_len=30                           # Número máximo de caracteres visibles
scroll_file="/tmp/mpd_scroll_offset" # Archivo temporal para el índice de desplazamiento

# Si el texto es corto, mostrarlo directamente
if [[ -z "$current" || ${#current} -le $max_len ]]; then
  echo "$current"
  exit 0
fi

# Leer el índice de desplazamiento actual
if [[ -f $scroll_file ]]; then
  offset=$(<"$scroll_file")
else
  offset=0
fi

# Calcular el texto desplazado
scroll_text="${current:offset:max_len}"
if ((${#scroll_text} < max_len)); then
  scroll_text="$scroll_text ${current:0:max_len-${#scroll_text}}"
fi

# Mostrar el texto desplazado
echo "$scroll_text"

# Actualizar el índice de desplazamiento
((offset++))
if ((offset >= ${#current})); then
  offset=0
fi
echo "$offset" >"$scroll_file"
