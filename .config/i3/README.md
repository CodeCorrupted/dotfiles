# I3 Configuration

Configuration of i3 centered on laptops with only one screen and to improve
my productivity and commodity.

## Installation

Clone this repo and then:

```sh
sudo pacman -S --needed i3-wm i3status i3lock

cp -r dotfiles/.config/i3 ~/.config
cp -r dotfiles/.config/i3status ~/.config
```

Also, you need to have the following programs to get all the features of this
configuration:

### Fonts

- [Hack Nerd Font, Hurmit Nerd Font and JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads).

### Programs that run at start

Just run the following script on your terminal:

```sh
sudo pacman -S --needed \
  xorg-xsetxkbmap picom connman-gtk redshift udiskie dunst mpd blueman-applet \
  xautolock feh
```

And the scripts `.scripts/battery_check.sh` and `.scripts/bright_status.sh`.

Run `feh` to set your wallpapper and modify the path to the `i3lock` image on
line 39 of `autostart.sh` (and the line 37 of `conf.d/bindings.conf`). Also,
modify as you like the command that `dunst` uses as its configuration.

### Programs on bindings

These programs are optional, so if you don't use any of them, just edit the
`conf.d/bindings.conf` and `conf.d/modes.conf` to change or delete the bindings
relationated to them:

```sh
sudo pacman -S --needed \
  kitty dmenu scrot vivaldi qutebrowser libreoffice-fresh geogebra obsidian \
  gimp keepassxc thunar gnome-calculator bleachbit telegram-desktop thunderbird \
  steam mgba-qt desmume ppsspp dolphin-emu

# Install from AUR
yay -S --needed umlet pomotroid-bin citra
```

And the scripts:

- `.scripts/dmenu_window.sh`
- `.scripts/power_menu_dmenu.sh`
- `.scripts/volume_control.sh`
- `.scripts/brightness_control.sh`

## Bindings

The main or **modifier** key is the _Windows_ key, from now on it will be referred
to as $mod.

All these bindings are set in the `bindings.conf` and `workspaces.conf` files.

### Focus & Swap

| Key                           | What it does                                            |
| ----------------------------- | ------------------------------------------------------- |
| `$mod+{h,j,k,l}`              | Focus the window at the left/down/up/right              |
| `$mod+Shift+{h,j,k,l}`        | Swap with the window at the left/down/up/right          |
| `$mod+{1-9,0}`                | Focus workspace 1-10                                    |
| `$mod+Shift+{1-9,0}`          | Send focused window at workspace 1-10                   |
| `$mod+n`/`$mod+p`             | Focus next/previous occupied workspace                  |
| `$mod+Shift+n`/`$mod+Shift+p` | Send focused window at next/previous occupied workspace |

### Actions on windows & Layouts

| Key      | What it does                             |
| -------- | ---------------------------------------- |
| `$mod+q` | Kill focused window                      |
| `$mod+t` | Toggle split orientation on stack layout |
| `$mod+f` | Toggle fullscreen mode on focused window |
| `$mod+s` | Set stacking layout                      |
| `$mod+w` | Set tabbed layout                        |

### i3

| Key            | What it does                       |
| -------------- | ---------------------------------- |
| `$mod+Shift+c` | Reload configuration file of i3-wm |
| `$mod+Shift+r` | Restart i3-wm                      |
| `ctrl+Mod1+l`  | Lock screen (`Mod1` is `Alt` key)  |

### Applications

| Key                                           | What it does                                                 |
| --------------------------------------------- | ------------------------------------------------------------ |
| `$mod+Return`                                 | Launch Kitty terminal                                        |
| `$mod+Print`/`$mod+Mod1+s`                    | Take a screenshot and save it on `~/Images/Screenshots/`     |
| `$mod+Shift+Print`/`$mod+Shift+s`             | Section to screenshot and save it on `~/Images/Screenshots/` |
| `XF86AudioRaiseVolume`/`XF86AudioLowerVolume` | +/- 10% volume (uses `.scripts/volume_control.sh`)           |
| `XF86AudioMute`                               | Mute volume (uses `.scripts/volume_control.sh`)              |
| `XF86MonBrightnessUp`/`XF86MonBrightnessDown` | +/- 5% brightness (uses `.scripts/brightness_control.sh`)    |

## Modes

Modes are triggered with the following keys:

| Key      | What it does                              |
| -------- | ----------------------------------------- |
| `$mod+v` | Volume mode (controls the volume)         |
| `$mod+b` | Brightness mode (controls the brightness) |
| `$mod+i` | Internet mode                             |
| `$mod+o` | Office mode                               |
| `$mod+u` | Utillities mode                           |
| `$mod+m` | Messaging mode                            |
| `$mod+g` | Gaming mode                               |
| `$mod+r` | Resize mode                               |

To get out of any mode, you just have to use the `Return` or `Esc` key.

### Volume mode

| Key | What it does     |
| --- | ---------------- |
| `u` | Raise volume 10% |
| `d` | Low volume 10%   |
| `m` | Mute volume      |

### Brightness mode

| Key | What it does        |
| --- | ------------------- |
| `u` | Raise brightness 5% |
| `d` | Low brightness 5%   |

### Internet mode

| Key | What it does                                    |
| --- | ----------------------------------------------- |
| `q` | Launch [Qutebrowser](https://qutebrowser.org/)  |
| `v` | Launch [Vivaldi](https://vivaldi.com/download/) |

### Office mode

| Key | What it does                                         |
| --- | ---------------------------------------------------- |
| `g` | Launch [Geogebra](https://www.geogebra.org/download) |
| `l` | Launch [LibreOffice](https://www.libreoffice.org/)   |
| `o` | Launch [Obsidian](https://obsidian.md/)              |
| `i` | Launch [GIMP](https://www.gimp.org/downloads/)       |
| `u` | Launch [UMLet](https://www.umlet.com/)               |

### Utillities mode

| Key | What it does                                            |
| --- | ------------------------------------------------------- |
| `k` | Launch [KeePassXC](https://keepassxc.org/)              |
| `p` | Launch [Pomotroid](https://github.com/Splode/pomotroid) |
| `t` | Launch [Thunar](https://github.com/neilbrown/thunar)    |
| `c` | Launch [Calculator](https://apps.gnome.org/Calculator/) |
| `b` | Launch [BleachBit](https://www.bleachbit.org/)          |

### Messaging mode

| Key | What it does                                                             |
| --- | ------------------------------------------------------------------------ |
| `t` | Launch [Telegram](https://desktop.telegram.org/)                         |
| `h` | Launch [Thunderbird](https://www.thunderbird.net/en-US/thunderbird/all/) |

### Gaming mode

| Key | What it does                                        |
| --- | --------------------------------------------------- |
| `s` | Launch [Steam](https://store.steampowered.com/)     |
| `m` | Launch [mGBA](https://mgba.io/)                     |
| `c` | Launch [Citra](https://citra-emulator.com/)         |
| `d` | Launch [DeSmuME](https://www.desmume.com/)          |
| `p` | Launch [PPSSPP](https://www.ppsspp.org/)            |
| `o` | Launch [Dolphin Emulator](https://dolphin-emu.org/) |

### Resize mode

| Key         | What it does          |
| ----------- | --------------------- |
| `h`/`Left`  | Shrink width for 3px  |
| `l`/`Right` | Grow width for 3px    |
| `k`/`Up`    | Shrink height for 3px |
| `j`/`Down`  | Grow height for 3px   |
