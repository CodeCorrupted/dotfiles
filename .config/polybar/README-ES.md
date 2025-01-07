# Configuración de Polybar

Estos son mis archivos de configuración para que Polybar funcione con i3 wm.

Fueron probados en Artix Linux, asi que es probable que no funcione en otros
 sistemas.

## Instalación

Antes de instalar, necesitas las siguientes cosas:

- [MPD][1].
- [Pulseaudio][2].
- [I3][3].
- [JetBrains Mono Nerd Fonts and Hack Nerd Fonts][4].
- [Pywal][5].

Luego de eso, instala Polybar y después copia estos archivos en el directorio
 `~/.config/`.

Para ser capaz de cambiar el brillo con solo hacer scroll con el mouse sobre
 el modulo de brillo, necesitas adherir a tu usuario al grupo de "video":

```bash
sudo usermod --append --groups=video <usuario>
```

Entonces, debes editar/crear un archivo (aquí uso vim, pero puede hacerse con
 cualquier editor):

```bash
sudo vim /etc/udev/rules.d/backlight.rules
# Agrega las siguientes lineas al archivo
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness",
 RUN+="/bin/chmod g+w $sys$devpath/brightness"
```

Guarda y sal. Ahora serás capaz de aumentar o disminuir el brillo de la
 pantalla con solo hacer scroll con tu mouse sobre el modulo de brillo.

## Cómo realizar cambios

El archivo `config.ini` contiene únicamente las configuraciones de la barra.
 Los modulos se encuentran en el directorio `modules/`, importados por el
 archivo `modules.ini` qué es cargado en el archivo `config.ini`.

Los colores son definidos en el archivo `colors.ini`, el cuál usa los colores
 definidos por pywal.

Finalmente, cada modulo usado que reside en el directorio `modules/` tiene
 un nombre muy intuitivo. Sabrás de una leída cuál archivo pertenece a
 qué modulo.

[1]: https://mpd.readthedocs.io/en/latest/
[2]: https://wiki.archlinux.org/title/PulseAudio
[3]: https://i3wm.org/
[4]: https://www.nerdfonts.com/#home
[5]: https://github.com/dylanaraps/pywaludo
