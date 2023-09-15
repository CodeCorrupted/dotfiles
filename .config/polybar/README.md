# Polybar config

These are my config files for Polybar to work on I3 wm.

Were proved on Artix Linux, so it may don't work on other systems.

## Installation

Before install, you need the following things:

- [MPD][1].
- [Pulseaudio][2].
- [I3][3].
- [JetBrains Mono Nerd Fonts and Hack Nerd Fonts][4].
- [Pywal][5].

After that, install Polybar and then copy these files on the `~/.config/`
 directory.

To be able to change the bright with just scrolling over the module of
 backlight, you need to add your user at the "video" group:

```bash
sudo usermod --append --groups=video <usuario>
```

Then, you have to edit/create a file (here I use vim, but can be any editor):

```bash
sudo vim /etc/udev/rules.d/backlight.rules
# Add the following lines to the file
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness",
 RUN+="/bin/chmod g+w $sys$devpath/brightness"
```

Save and quit. Now you'll be able to scrolling to change the bright of
 the screen.

## How to make changes

The file `config.ini` contains only the settings of the bar. The modules
 are on the directory `modules/`, imported by the file `modules.ini` which is
 loaded on the `config.ini` file.

The colors are defined on the `colors.ini` file, which uses colors defined
 by pywal.

Finally, every module used that reside on the `modules/` directory has a
 very self-descriptive name. You will know which file belongs to what
 module with just a read.

[1]: https://mpd.readthedocs.io/en/latest/
[2]: https://wiki.archlinux.org/title/PulseAudio
[3]: https://i3wm.org/
[4]: https://www.nerdfonts.com/#home
[5]: https://github.com/dylanaraps/pywal
