# Alacritty Configuration

A minimal Alacritty setup that keeps the defaults you love and sprinkles in a
few quality-of-life tweaks.

## Features

- **Font**: Terminess Nerd Font (icons & ligatures included).
- **Subtle UI Tweaks**:
  - No window decorations (clean look).
  - Clipboard copy on selection.
  - Underline cursor that always blink.
  - Hide mouse while typing.
  - `Ctrl+Shift+Return` spawns a new Alacritty instance.

## Quickstart

First, you need to install [Terminess Nerd Font][1]. Then, clone this repo and:

```sh
mkdir -p ~/.config/alacritty/
cp dotfiles/.config/alacritty/*.toml ~/.config/alacritty/
```

If you already use `pywal`, run the script `wal_alacritty.sh`, which will change
the colors of Alacritty to match with your wallpapper.

If you don't have `pywal`, but you want to use it, along with my scripts, go to
`.scripts/` directory to checkout what you need to get started with those files.

Anyway, none of those scripts are mandatory. You can change the colors of
Alacritty by hand editing the file `colors.toml`.

## Customize

The options to customize this configuration are described on [Alacritty's
Documentation][2].

[1]: https://www.nerdfonts.com/font-downloads
[2]: https://alacritty.org/config-alacritty.html
