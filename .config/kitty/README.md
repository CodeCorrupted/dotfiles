# Config file of Kitty

[Kitty][1] is a terminal emulator that is meant to be used principally with
 keyboard. Now, I will explain what you need to make this config file works
 correctly on your system.

This file was made on Artix Linux, so it probably won't work fine on another
 distro of Linux (but that shouldn't matter).

## Installation

Besides copying this files inside your `$HOME/.config/kitty/` directory,
 you need to install:

- [JetBrains Mono Nerd Fonts][2].
- [Imagemagick][3].
- [Pywal][4].

Imagemagick it's very important to be able to see images on the terminal.

Pywal is used to define the colorscheme of kitty.

## Features

I haven't change much the default configuration. Here's a list of changes I've done:

- Change the fonts for JetBrains Mono Nerd Fonts.
- Change the color of terminal's cursor.
- Hide the mouse cursor when typing.
- Style of the links.
- A bell icon compatible with JetBrains Mono Nerd Fonts.
- Layout Tall.
- Fade the text on inactive windows a %30.
- Hide window decorations.
- Don't check for available updates.
- Shortcuts:
  - Ctrl + Shift + 1 to 9 to change of tabs.
  - Ctrl + plus: increase the font size.
  - Ctrl + minus: decrease the font size.
  - Ctrl + backspace: reset font size.
- Scheme colors.

[1]: https://sw.kovidgoyal.net/kitty/quickstart/
[2]: https://github.com/ryanoasis/nerd-fonts
[3]: https://imagemagick.org/index.php
[4]: https://github.com/dylanaraps/pywal
