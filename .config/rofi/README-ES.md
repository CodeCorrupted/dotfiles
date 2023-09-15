# Configuración de Rofi

[Rofi][1] es un lanzador de aplicaciones. Este archivo de configuración
 solo le dice a Rofi la fuente y los iconos a usar y algunas cosas
 sobre el despliegue de la ventana. El tema usado es el que provee
 [Pywal][2].

## Instalación

Solo necesitas copiar el archivo `config.rasi` al directorio
 `$HOME/.config/rofi/`. También, asegúrate de tener las siguientes
 dependencias:

- [Hack Nerd Font][3].
- [Candy-icons][4].
- Pywal.

Ahora solo debes ejecutarlo de la siguiente forma y ya puedes
 disfrutar de Rofi:

```bash
rofi -show drun
```

[1]: https://github.com/davatorium/rofi
[2]: https://github.com/dylanaraps/pywal
[3]: https://www.nerdfonts.com/font-downloads
[4]: https://github.com/EliverLara/candy-icons
