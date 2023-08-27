# Archivo de configuración de Kitty

[Kitty][1] es un emulador de terminal hecho para ser usado principalmente por teclado. Ahora, te explicaré lo que necesitas para que este archivo de configuración funcione correctamente en tu sistema.

Este archivo se hizo en Artix Linux, así que es probable que no funcione apropiadamente en otras distribuciones.

[1]: https://sw.kovidgoyal.net/kitty/quickstart/

# Instalación

Además de copiar estos archivos en tu directorio `$HOME/.config/kitty/`, necesitas instalar:

- [JetBrains Mono Nerd Fonts][2].
- [Imagemagick][3].

[2]: https://github.com/ryanoasis/nerd-fonts
[3]: https://imagemagick.org/index.php

Imagemagick es muy importante para poder visualizar imágenes por la terminal.

# Características

No he cambiado muchas cosas de la configuración por defecto. Aqui la lista de los cambios realizados:

- Cambiar las fuentes por defecto por las de JetBrains Mono Nerd Fonts.
- Cambiar el color del cursor de la terminal.
- Esconder el cursor del mouse al teclear.
- La forma de ver los links.
- Un ícono de campana compatible con JetBrains Mono Nerd Fonts (por si quieres verla cuando actives la decoración de ventanas).
- Layout Tall (distribución de la división de ventanas en la terminal).
- Transparencia de un %70 del texto en ventanas inactivas.
- Esconder la decoración de ventanas.
- No buscar actualizaciones disponibles.
- Atajos de teclado:
  - Ctrl + Shift + 1 to 9 para cambiar de pestañas.
  - Ctrl + plus: incrementa el tamaño de la fuente.
  - Ctrl + minus: disminuye el tamaño de la fuente.
  - Ctrl + backspace: reinicia el tamaño de la fuente.
- Esquema de colores.
