# Dotfiles

This repository has all the configurations for my environment on `i3` and `bspwm`
used on Artix with OpenRC as init and Xorg as display server.

Each program that I've configured has its own README describing what it does,
how to modify it and how to install it.

In this README, I'll explain how to install everything and nothing more.

## Installation

After your clean install of Artix with OpenRC init, set connman as network
manager, pulseaudio as audio server, blueman as bluetooth manager and enable
AUR repository, clone this repo. Then:

```sh
# Install needed packages
sudo pacman -S --needed \
  bat lsd git kitty alacritty polybar i3-wm i3lock bspwm dunst acpi \
  inotify-tools pamixer wmctrl xorg-apps mpc mpd python xorg-server \
  python-pywal dmenu rofi feh xwallpapper ncmpcpp neovim sxhkd vivaldi \
  qutebrowser scrot geeqie redshift pavucontrol picom nodejs tar curl \
  unzip gzip npm typescript ripgrep fd chafa ffmpegthumbnailer poppler \
  connman-gtk udiskie blueman-applet xautolock bleachbit \
  gimp libreoffice-fresh gnome-calculator thunar keepassxc geogebra \
  obsidian telegram-desktop thunderbird steam mgba-qt desmume ppsspp \
  dolphin-emu fastfetch wmname bat lsd zsh

yay -S betterlockscreen umlet citra pomotroid-bin

# copy the files of this repo
cp -r dotfiles/.scripts dotfiles/.config ~/
```

Please, install too:

- [Hack, JetBrains, Hurmit and Terminess Nerd Font](https://www.nerdfonts.com/font-downloads)
- [candy-icons](https://www.gnome-look.org/s/Gnome/p/1305251/),
  [tela-nord-icons](https://www.gnome-look.org/p/1279924) and/or
  [breeze-dark](https://github.com/KDE/breeze-icons)

The following packages are some tools that I use but aren't needed for this
dotfiles:

```sh
sudo pacman -S --needed btop mugshot ranger simplescreenrecorder vlc \
  openjdk8-src openjdk17-src openjdk21-src netbeans mysql-workbench dbeaver \

yay -S lightdm-webkit2-glorious-theme
```

Install [IntelliJ](https://www.jetbrains.com/idea/download/?section=windows) and
remember to configure `lightdm` to use the [glorious theme](https://github.com/eromatiya/lightdm-webkit2-theme-glorious)
Also, install [darkmatter-grub-theme](https://gitlab.com/VandalByte/darkmatter-grub-theme)

### About `.zshrc`

This file contains some aliases and env variables. Besides that, it just have
the normal features that anyone sets for the zshell.
