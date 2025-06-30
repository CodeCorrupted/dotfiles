# BSPWM

There are a few diffs between this configuration and the default one. This diffs
are:

- Autostart of applications.
- Some rules for specific windows.

## Dependencies

There's no such thing like real dependencies here. All of them are optional, but
if you want to this to work from the start, you better have the following things:

- [Xwallpapper](https://github.com/stoeckmann/xwallpaper)
- [Polybar](https://github.com/polybar/polybar)
- [Picom](https://github.com/yshui/picom)
- [Connman-gtk](https://github.com/jgke/connman-gtk)
- [Redshift](https://github.com/jonls/redshift)
- [Udiskie](https://github.com/coldfix/udiskie)
- [Dunst](https://dunst-project.org/documentation/)
- [MPD](https://www.musicpd.org/)
- [Blueman](https://wiki.archlinux.org/title/Blueman)
- [Xautolock](https://wiki.archlinux.org/title/Session_lock#xautolock)
- [Betterlockscreen](https://github.com/betterlockscreen/betterlockscreen)

All those "dependencies" run at start through the `autostart.sh` file.

## About

The main configuration is on bspwmrc. The windows of the following applications
are initiated as floating windows:

- [mGBA](https://mgba.io/)
- [Citra](https://citra-emulator.com/)
- [PPSSPP](https://www.ppsspp.org/)
- [m64py](https://m64py.sourceforge.net/)
- [Dolphin (emulator)](https://dolphin-emu.org/)
- [Connman-gtk](https://github.com/jgke/connman-gtk)
- [Blueman](https://wiki.archlinux.org/title/Blueman)
- [Snes9x](https://www.snes9x.com/)
- [Calculator (gnome)](https://gitlab.gnome.org/GNOME/gnome-calculator)
- [SimpleScreenRecorder](https://github.com/MaartenBaert/ssr)
- [Gimp](https://www.gimp.org/downloads/)
- And every menu application or similar (those that should be displayed as
  floating windows).

The last one is defined with the file `external_rules.sh`, since bspc can't
do this without some external help.

The `autostart.sh` file just run the applications listed on the dependencies
sections. You can edit it to put your favorite applications instead.
