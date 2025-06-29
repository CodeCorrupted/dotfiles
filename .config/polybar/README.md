# Polybar

This is the configuration for the panel used on bspwm.

[Polybar image](../../assets/screenshots/polybar_sample.png)

## Dependencies

This configuration uses:

- Scripts on `.scripts` folder.
- [Betterlockscreen][1]
- [Alacritty][2]
- [JetBrains and Hack Nerd Font][3]
- [Xbacklight][4] (bright module)
- [Rofi][5] (as an application launcher and power management)
- [MPD][6]
- [PulseAudio][7]

## About

The `config.ini` file just define the distribution of the modules of polybar and
the import of `colors.ini`, `modules.ini` and `fonts.ini`. The `modules.ini`
brings everything thats inside the `modules` directory, which have all the
modules used on this panel. The `bar-tray.ini` file defines the bar that is
displayed by `arrow-tray.ini` module.

If you won't use this on bspwm, edit the `config.ini` file to set your window
manager on line 34 and the `modules/workspaces.ini` file, line 2, to use the
related workspace.

On a fresh install, you must edit the `modules/battery.ini` file to set your
battery and adapter to work properly.

I don't believe that more explanations are needed. The files explain by themselves
what tasks they supose to do.

[1]: https://github.com/betterlockscreen/betterlockscreen
[2]: https://alacritty.org/
[3]: https://www.nerdfonts.com/font-downloads
[4]: https://wiki.archlinux.org/title/Backlight
[5]: https://github.com/davatorium/rofi
[6]: https://mpd.readthedocs.io/en/latest/
[7]: https://wiki.archlinux.org/title/PulseAudio
