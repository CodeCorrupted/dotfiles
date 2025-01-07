# I3 config file

These are my config files for the [Tiling Windows Manager][1] [i3][2].

Were made with this things on mind:

1. To use on Artix Linux with OpenRC as init.
2. With a %60 keyboard and only one layout, ES-latam in this case.
3. Only one Screen.

This means that you can't find an use to special keys, probably some keybindings
 doesn't work if you have another layout or some things won't work as expected
 when trying to run this config file on another distro of Linux.

## Installation

Besides to clone this folder on your `$HOME/.config/` directory, you need to install:

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

Some programs are optional, but if you want that all the keybindings work, you have
 to install all of them.

## Bindings

The main or **modifier** key is the _Windows_ or _Super_ key, from now on it will
 be referred to as $mod. This means that you need that key for almost every keybinding.

### Launch some applications (without entering into some mode)

- $mod + Return: launch the terminal's emulator.
- $mod + d: launch rofi, a menu of applications.
- $mod + c: launch rofi as a calculator.
- $mod + x: take a screenshot with scrot.

### Focus and splits on windows

- $mod + Shift + q: kill the focused window.
- $mod + j: focus left window.
- $mod + k: focus bottom window.
- $mod + l: focus top window.
- $mod + ñ: focus right window.
- $mod + Shift + j: switch places of the focused window with the window at the left.
- $mod + Shift + k: switch places of the focused window with the window at bottom.
- $mod + Shift + l: switch places of the focused window with the window at top.
- $mod + Shift + ñ: switch places of the focused window with the window at the right.
- $mod + h: horizontal split.
- $mod + v: vertical split.
- $mod + t: toggle between vertical and horizontal split.
- $mod + Shift + Space: switch the window between tiling and floating mode.
- $mod + Space: switch focus between the floating and tiling window.
- $mod + a: focus the parent window of the container.

### Layouts

- $mod + f: toggles fullscreen mode and actual mode.
- $mod + s: select stack layout.
- $mod + w: select tabbed layout.
- $mod + e: select split layout.

### Actions on I3

- $mod + Shift + c: reload the config file.
- $mod + Shift + r: restart i3.
- $mod + Shift + e: execute a command to confirm the exit and logout of i3 session.
- $mod + Alt + l: block the screen.

### Modes on I3

- $mod + r: resize. Here you can modify the sizes of the windows (if there are more
 than one in the workspace):
  - j or Left: shrink width in 3px.
  - k or Down: grow height in 3px.
  - l or Up: shrink height in 3px.
  - ñ or Right: grow width in 3px.
- $mod + u: Volume mode. Here, we can control the volume of the system.
  - u: volume up by 10%.
  - d: volume down by 10%.
  - m: volume mute.
- $mod + y: Bright mode. With this mode, we can control the brightness of the screen.
  - u: 5% more bright.
  - d: 5% less bright.
- $mod + i: Internauta mode. For applications to navigate.
  - t: launch Thunderbird.
  - f: launch Firefox.
  - q: launch Qutebrowser.
- $mod + o: explorer mode. For some applications that i frecuently use.
  - k: launch Keepass.
  - v: launch VLC.
  - p: launch Pomotroid.
- $mod + g: gaming mode. This one is for applications to play videogames.
  - s: launch Steam.
  - m: launch mGBA.
- $mod + m: chat mode. For applications to chat with people.
  - t: launch Telegram.
  - d: launch Discord.
- $mod + z: zystem mode. With this, you can logout, reboot or shutdown the system.
  - s: shutdown.
  - r: reboot.
  - l: logout.

### Mouse bindings

- $mod + right button: toggle between floating window and tiling window.
- $mod + lef button: allows you to drag a window.

### Workspaces

- $mod + 1 to 0: allows you to move between the 10 workspaces of I3.
- $mod + Shift + 1 to 0: move the focused container to another workspace.
- $mod + b: move between workspaces back and forth.
- $mod + Shift + b: move the focused container between workspaces back and forth.
- $mod + n: move to the next workspace.
- $mod + p: move to the previous workspace.
- $mod + Shift + n: move the focused window to the next workspace.
- $mod + Shift + p: move the focused window to the previous workspace.

## Some more features

Some applications were assigned to specific workspaces, here I leave you
 a list of them:

- Kitty terminal on workspace 1.
- Qutebrowser and Firefox on workspace 2.
- MuPDF and Comix windows on workspace 3.
- Telegram and Discord on workspace 4.
- Steam and mGBA on workspace 5.
- [NetBeans IDE](https://netbeans.apache.org/) on workspace 6.
- [MySQL Workbench](https://www.mysql.com/products/workbench/) on workspace 7.
- [Geeqie](https://www.geeqie.org/) and Nitrogen on workspace 8.
- VLC on workspace 9.
- Connman, Keepass and Thunderbird on workspace 10.

## How to make changes?

I split the config file in others files on the directory `conf.d`, where the
 names are self-explanatory. This was made for an easy maintenance. You can
 change it as you like.

The only thing that I keep on the config file are: an `include` which adds
 all the files in the `conf.d` directory; the variable of $mod, which the
 others files use it; and the execution of Polybar.

[1]: https://en.wikipedia.org/wiki/Tiling_window_manager
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
