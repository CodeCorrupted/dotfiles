#!/bin/bash

# Verificar si se pasó una imagen como argumento
if [ -z "$1" ]; then
  echo "Por favor, proporciona una imagen como argumento."
  exit 1
fi

# Ruta a la imagen proporcionada
IMAGE_PATH=$(realpath "$1")

# Reemplazar /home/user por $HOME en la ruta de la imagen
IMAGE_PATH="${IMAGE_PATH/$HOME/\$HOME}"

# Definir el archivo autostart de configuración de i3lock (ajusta esta ruta si es diferente)
LOCK_SCREEN_AUTORUN="$HOME/.config/i3/autostart.sh"
sed -i "s|xautolock -detectsleep -time .* -locker .*|xautolock -detectsleep -time 30 -locker \"i3lock --image=$IMAGE_PATH\"|" "$LOCK_SCREEN_AUTORUN"

# Actualizar el atajo de teclado en el archivo de configuración de i3
I3_CONFIG="$HOME/.config/i3/conf.d/bindings.conf"
sed -i "s|--image=.*|--image=$IMAGE_PATH|" "$I3_CONFIG"

# Actualizar el script power-menu
SCRIPT_POWER="$HOME/.scripts/power-menu.sh"
sed -i "s|--image=.*|--image=$IMAGE_PATH|" "$SCRIPT_POWER"

# Recargar i3wm
i3-msg reload
i3-msg restart

# Confirmar la actualización
echo "La imagen de bloqueo y las configuraciones han sido actualizadas correctamente."
