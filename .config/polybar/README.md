# Polybar Configuration

Minimal panel for `bspwm`.

Designed to stay out of the way while still showing you everything you need.

![Polybar image](../../assets/screenshots/polybar_sample.png)

## Quickstart

First, make sure you have:

- [Hack and JetBrains Nerd Font](https://www.nerdfonts.com/font-downloads)

```sh
# Install
sudo pacman -S --needed \
  mpd polybar pulseaudio alacritty betterlockscreen xbacklight rofi \
  pavucontrol bspwm

# Copy
cp dotfiles/.config/polybar ~/.config
```

You also need the following scripts under `~/.scripts` directory:

- `volume_control.sh`
- `bar_tray_file_state.sh`
- `label-mpd.py`
- `power_menu_rofi.sh`

When everything is setup, you just need to edit the `modules/battery.ini` file
to set the correct name of your battery and adapter on lines 8 and 9.

## Customize

### Files under this directory

| File           | What it contains                                                             |
| -------------- | ---------------------------------------------------------------------------- |
| `config.ini`   | Defines the look of the main panel and how to display the modules on polybar |
| `colors.ini`   | Defines the colors used by this configuration                                |
| `fonts.ini`    | Defines the fonts used by this configuration                                 |
| `launch.sh`    | Script to launch the main bar                                                |
| `modules.ini`  | File that imports every module on `modules` directory                        |
| `bar-tray.ini` | Defines propperties of the bar that displays the system tray                 |

### Files under `modules` directory

| File                                 | What it contains                                                                              |
| ------------------------------------ | --------------------------------------------------------------------------------------------- |
| `arrow-tray.ini`                     | Custom module to launch the panel with the system tray                                        |
| `backlight.ini`                      | Xbacklight module. You can scroll on it to raise/lower the brightness                         |
| `battery.ini`                        | Battery module. At %20 uses an animation for low battery                                      |
| `border-left.ini`/`border-right.ini` | Text modules used as inside border of the panel                                               |
| `date.ini`                           | Date module. If you left click it, show the current date. Otherwise, show the current time    |
| `launcher.ini`                       | Text module with Artix glyph. If you left click it, run the app launcher through `rofi`       |
| `memory.ini`                         | Memory module. Show the current occupied RAM (percentage)                                     |
| `mpd-label.ini`                      | Custom module that displays the name and artist of current song                               |
| `mpd.ini`                            | MPD module. Configured to only show the previous, play/pause and next buttons                 |
| `power-button.ini`                   | Text module with power glyph. If you left click it, it displays the power menu through `rofi` |
| `pulseaudio.ini`                     | Pulseaudio module. Click left on it mutes the volume. Scroll to raise/lower volume at 5% step |
| `separator.ini`                      | Text module to define the space between modules                                               |
| `workspaces.ini`                     | bspwm module. Scroll to change to prev/next workspace or click left on one of them            |
