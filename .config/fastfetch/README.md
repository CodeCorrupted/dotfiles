# Fastfetch Configuration

Simple and minimal configuration for fastfetch:

[Preview](../../assets/screenshots/fastfetch_preview.png)

## Quickstart

Clone this repo and then:

```sh
sudo pacman -S --needed fastfetch

mkdir -p ~/.config/fastfetch
cd dotfiles/.config/fastfetch/
cp ascii.txt config.jsonc ~/.config/fastfetch
```

You also need to set a [patched font](https://www.nerdfonts.com/font-downloads)
as the font used by your terminal.

## Customize

The `ascii.txt` file contains the ASCII art to display for fastfetch. You can
replace it for anything you like.

The `config.jsonc` file contains the configuration itself.
