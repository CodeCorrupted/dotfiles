# Archivo de configuración de I3

Estos son mis archivos de configuración para el [Gestor de Ventanas en Mosaico][1]
 [I3][2].

Fueron hechos con estas cosas en mente:

1. Para usarse en Artix Linux con OpenRC como init.
2. Con un teclado de %60 con solo una distribución, ES-latam en este caso.
3. Solo una pantalla.

Esto quiere decir que no encontrarás ningún uso para teclas especiales, que algunos
 atajos de teclado pueden no funcionar si posees otra distribución de teclado o que
 algunas cosas no funcionen bien al estar en otra distro de Linux.

## Instalación

Además de clonar esta carpeta en el directorio `$HOME/.config/`, necesitas instalar:

- [Hack Nerd Fonts][3].
- [Connman][4].
- [Picom][5].
- [Nitrogen][6].
- [Pywal][7].
- [MPD][9].
- [Brightnessctl][10].
- [Redshift][11].
- [Parcellite][28].
- [Kitty][12].
- [Rofi][13].
- [Candy Icons][14].
- [Scrot][15].
- [Pulseaudio][16].
- [Firefox][17].
- [Thunderbird][18].
- [Qutebrowser][19].
- [Keepass][20].
- [VLC][21].
- [Pomotroid][22].
- [Steam][23].
- [mGBA][24].
- [Telegram][25].
- [Discord][26].
- [Polybar][27].

Algunos programas son opcionales, pero si quieres que todos los atajos de teclado
 funcionen, debes instalarlos.

## Atajos de teclado

La tecla principal o **modificadora** es la tecla _Windows_ o _Super_, de ahora
 en más referidos como $mod. Esto quiere decir que será una tecla necesaria
 para los atajos de teclado.

### Lanzar algunas aplicaciones (sin entrar a ningún modo)

- $mod + Enter: abre una ventana de Kitty (emulador de terminal).
- $mod + d: abre Rofi, un menú de aplicaciones.
- $mod + c: abre Rofi como una calculadora.
- $mod + x: ejecuta un comando con Scrot para tomar una captura de pantalla.

### Foco y división de ventanas

- $mod + Shift + q: cierra la ventana que está enfocada.
- $mod + j: enfoca la ventana a la izquierda.
- $mod + k: enfoca la ventana inferior.
- $mod + l: enfoca la ventana superior.
- $mod + ñ: enfoca la ventana a la derecha.
- $mod + Shift + j: cambia de lugar la ventana enfocada con la que está a su izquierda.
- $mod + Shift + k: cambia de lugar la ventana enfocada con la que está debajo de
 esta.
- $mod + Shift + l: cambia de lugar la ventana enfocada con la que está arriba de
 esta.
- $mod + Shift + ñ: cambia de lugar la ventana enfocada con la que está a su derecha.
- $mod + h: división horizontal.
- $mod + v: división vertical.
- $mod + t: alterna entre las divisiones horizontal y vertical.
- $mod + Shift + Space: cambia/alterna una ventana del modo mosaico y modo flotante.
- $mod + Space: cambia el foco entre una ventana flotante y una ventana en mosaico.
- $mod + a: enfoca la ventana padre del container.

### Distribución de ventanas

- $mod + f: alterna entre el modo actual y el de pantalla completa.
- $mod + s: selecciona la distribución stack.
- $mod + w: selecciona la distribución tabbed.
- $mod + e: selecciona la distribución split.

### Acciones en I3

- $mod + Shift + c: recargar el archivo de configuración.
- $mod + Shift + r: reiniciar I3.
- $mod + Shift + e: ejecutar un comando para confirmar el cierre de i3 y salida de
 la sesión.
- $mod + Alt + l: bloquear la pantalla.

### Modos en I3

- $mod + r: resize. Aquí puedes modificar los tamaños de las ventanas (si hay más
 de una ventana en el espacio de trabajo).
  - j o Flecha Izquierda: achica el ancho en 3px.
  - k o Flecha Abajo: agranda la altura en 3px.
  - l o Flecha Arriba: achica la altura en 3px.
  - ñ o Flecha Derecha: agranda el ancho en 3px.
- $mod + u: Volume mode. Este modo es para controlar el volumen.
  - u: subir el volumen un 10%.
  - d: bajar el volumen un 10%.
  - m: enmudecer el volumen.
- $mod + y: Bright mode. Con este modo, controlamos el brillo de la pantalla.
  - u: subir el brillo un 5%.
  - d: subir el brillo un 5%.
- $mod + i: Internauta mode. Para las aplicaciones de navegación.
  - t: abre Thunderbird.
  - f: abre Firefox.
  - q: abre Qutebrowser.
- $mod + o: explorer mode. Para abrir algunas aplicaciones que uso frecuentemente.
  - k: abre Keepass.
  - v: abre VLC.
  - p: abre Pomotroid.
- $mod + g: gaming mode. Este es para las aplicaciones para jugar videojuegos.
  - s: abre Steam.
  - m: abre mGBA.
- $mod + m: chat mode. Con este se abren aplicaciones para chatear.
  - t: abre Telegram.
  - d: abre Discord.
- $mod + z: zystem mode. Y este modo te permite cerrar sesión, reiniciar o
 apagar el sistema.
  - s: apagar.
  - r: reiniciar.
  - l: cerrar sesión.

### Atajos del ratón

- $mod + right button: alterna la ventana entre modo mosaico y flotante.
- $mod + lef button: te permite arrastrar una ventana al lugar que quieras.

### Espacios de trabajo (Workspaces)

- $mod + 1 to 0: te permite desplazarte entre los 10 diferentes espacios de
 trabajo de I3.
- $mod + Shift + 1 to 0: mueve el contendor en foco a otro espacio de trabajo.
- $mod + b: te desplazas entre el espacio de trabajo actual y en anterior.
- $mod + Shift + b: mueves el contenedor enfocado entre los espacios de trabajo
anterior y siguiente.
- $mod + n: te desplazas al proximo espacio de trabajo.
- $mod + p: te desplazas al espacio de trabajo anterior.
- $mod + Shift + n: mueves la ventana enfocada al proximo espacio de trabajo.
- $mod + Shift + p: mueves la ventana enfocada al espacio de trabajo anterior.

## Otras características

Algunas aplicaciones fueron designadas a especificos espacios de trabajo, aquí
 los dejo enlistados:

- Terminal de Kitty en el espacio de trabajo 1.
- Qutebrowser y Firefox en el espacio de trabajo 2.
- Ventanas de MuPDF y Comix en el espacio de trabajo 3.
- Telegram y Discord en el espacio de trabajo 4.
- Steam y mGBA en el espacio de trabajo 5.
- [NetBeans IDE](https://netbeans.apache.org/) en el espacio de trabajo 6.
- [MySQL Workbench](https://www.mysql.com/products/workbench/) en el espacio de
 trabajo 7.
- [Geeqie](https://www.geeqie.org/) y Nitrogen en el espacio de trabajo 8.
- VLC en el espacio de trabajo 9.
- Connman, Keepass y Thunderbird en el espacio de trabajo 10.

## ¿Cómo realizar cambios?

Dividí el archivo de configuración en múltiples archivos que se encuentran en
 el directorio `conf.d`. Los nombres son intuitivos, así que sabrás de qué va
 cada uno con solo leerlo. Esto lo hice para que fuera más fácil de dar
 mantenimiento, aunque puedes hacer los cambios que creas necesarios.

Las únicas cosas que encontrarás en el archivo de configuración son: una línea
 `include` que incluye los archivos del directorio `conf.d`, la declaración de
 la variable $mod, que se usa en los demás archivos, y la ejecución de polybar.

[1]: https://es.wikipedia.org/wiki/Gestor_de_ventanas_en_mosaico
[2]: https://i3wm.org/
[3]: https://github.com/ryanoasis/nerd-fonts
[4]: https://wiki.archlinux.org/title/ConnMan
[5]: https://github.com/yshui/picom
[6]: https://wiki.archlinux.org/title/nitrogen
[7]: https://github.com/dylanaraps/pywal
[9]: https://mpd.readthedocs.io/en/latest/
[10]: https://man.archlinux.org/man/brightnessctl.1.en
[11]: https://github.com/jonls/redshift
[12]: https://sw.kovidgoyal.net/kitty/
[13]: https://github.com/davatorium/rofi
[14]: https://www.gnome-look.org/p/1305251/
[15]: https://github.com/resurrecting-open-source-projects/scrot
[16]: https://wiki.archlinux.org/title/PulseAudio
[17]: https://www.mozilla.org/en-US/firefox/new/
[18]: https://www.thunderbird.net/en-US/
[19]: https://qutebrowser.org/
[20]: https://keepass.info/
[21]: https://www.videolan.org/
[22]: https://github.com/Splode/pomotroid
[23]: https://store.steampowered.com/about/
[24]: https://mgba.io/
[25]: https://desktop.telegram.org/
[26]: https://discord.com/download
[27]: https://github.com/polybar/polybar
[28]: https://parcellite.sourceforge.net/
