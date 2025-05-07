#!/bin/bash
# Define la carpeta base donde se encuentra tu música
MUSIC_DIR="$HOME/Music" # Cambia esto por la ruta correcta a tu carpeta Music

# Busca solo los directorios que se asumen como álbumes: Music/Artista/Album (profundidad 2)
find "$MUSIC_DIR" -mindepth 2 -maxdepth 2 -type d | while read album_dir; do
  # En cada directorio de álbum se busca la imagen de portada (se asume que hay una)
  cover_image=$(find "$album_dir" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" \) | head -n 1)

  if [ -n "$cover_image" ]; then
    echo "Procesando álbum: $album_dir"
    echo "Portada encontrada: $cover_image"

    # Para cada archivo mp3 en el directorio actual
    for mp3_file in "$album_dir"/*.mp3; do
      # Verifica que existan archivos mp3
      if [ -e "$mp3_file" ]; then
        echo "Incrustando portada en: $mp3_file"
        # Crea un archivo temporal para la salida
        temp_file="${mp3_file%.mp3}_temp.mp3"

        # Usa ffmpeg para incrustar la imagen en el archivo mp3
        ffmpeg -nostdin -y -i "$mp3_file" -i "$cover_image" -map 0 -map 1 \
          -c copy -id3v2_version 3 "$temp_file" >/dev/null 2>&1

        if [ $? -eq 0 ]; then
          # Reemplaza el archivo original por el actualizado con la portada
          mv "$temp_file" "$mp3_file"
          echo "Actualizado: $mp3_file"
        else
          echo "Error al procesar: $mp3_file"
          # Elimina el archivo temporal en caso de error
          rm -f "$temp_file"
        fi
      fi
    done
  else
    echo "No se encontró imagen de portada en: $album_dir. Directorio omitido."
  fi
done
