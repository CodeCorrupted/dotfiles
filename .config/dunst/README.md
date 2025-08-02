# Dunst Configuration

A compact setup that:

- shows up to 4 pop-ups at once.
- positions them **top-right** with a subtle **rounded frame**.
- hides low-priority spam and highlights **critical** messages.

## Quickstart

First, you need to install:

- [Iosevka Nerd Font](https://www.nerdfonts.com/font-downloads)
- [candy-icons](https://www.gnome-look.org/s/Gnome/p/1305251/) and/or
  [tela-nord-icons](https://www.gnome-look.org/p/1279924) and/or
  [breeze-dark](https://github.com/KDE/breeze-icons)

Then, clone this repository and run on your terminal:

```sh
# Install dunst
sudo pacman -S dunst

# Copy this configuration
mkdir -p ~/.config/dunst/
cp dotfiles/.config/dunst/* ~/.config/dunst/

# Reload/start Dunst
pkill dunst && dunst &
```

## Customize

Checkout the [documentation of dunst](https://dunst-project.org/documentation/)
to learn about the available options for dunst. Then, you just have to modify
the files on this directory as you like (`dunstrc-bspwm` for `bspwm` and
`dunstrc-i3` for `i3`).

## Why so many files?

The `dunstrc` file is a fallback with defaults, in case that something breaks
on the other configurations.

There are a configuration for `bspwm` and another one for `i3` because the
colors. The script `set_update_wallpapper.sh` updates the colors of the frame
on each configuration to match with the `pywal` palette of the given image.
