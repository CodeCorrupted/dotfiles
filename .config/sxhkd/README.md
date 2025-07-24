# SXHKD Configuration

Minimal configuration of `sxhkd` to work on `bspwm`.

## Quickstart

To get all the keyboard shortcuts working at start, just run:

```sh
sudo pacman -S --needed \
  bspwm sxhkd alacritty rofi vivaldi qutebrowser scrot
```

You also need the scripts (under the `~/.scripts/` directory):

- `volume_control.sh` (rise/low the volume)
- `brightness_control.sh` (rise/low brightness)
- `power_menu_rofi.sh` (displays a power menu through rofi)

Please, checkout the dependencies needed for those scripts on `.scripts/README.md`

## Keymaps

Remember that `super` is the "Windows" key.

### Independent of the WM (Window Manager)

| Key                                     | What it does                                                                 |
| --------------------------------------- | ---------------------------------------------------------------------------- |
| `super+Return`                          | open terminal (`alacritty`)                                                  |
| `super+d`                               | open the app launcher (`rofi`)                                               |
| `super+Escape`                          | reset `sxhkd`                                                                |
| `super+Delete`                          | open the power menu (`~/.scripts/power_menu_rofi.sh`)                        |
| `super+i`/`super+Shift+i`               | open browser (`qutebrowser`/`vivaldi`)                                       |
| `XF86AudioRaiseVolume`/`super+v`        | +10% volume (`~/.scripts/volume_control.sh up`)                              |
| `XF86AudioLowerVolume`/`super+Shift+v`  | -10% volume (`~/.scripts/volume_control.sh down`)                            |
| `XF86AudioMute`/`super+Alt+v`           | mute volume (`~/.scripts/volume_control.sh mute`)                            |
| `XF86MonBrightnessUp`/`super+b`         | +5% brightness (`~/.scripts/brightness_control.sh up`)                       |
| `XF86MonBrightnessDown`/`super+Shift+b` | -5% brightness (`~/.scripts/brightness_control.sh down`)                     |
| `super+Print`/`super+Alt+s`             | full screenshot (use `scrot`, and is saved on `~/Images/Screenshots/`)       |
| `super+Shift+Print`/`super+Shift+s`     | section to screenshot (use `scrot`, and is saved on `~/Images/Screenshots/`) |
| `super+Tab`                             | switch to another window (`rofi`)                                            |

### Bspwm Hotkeys

| Key                       | What it does                                 |
| ------------------------- | -------------------------------------------- |
| `super+Alt+r`             | reset `bspwm`                                |
| `super+w`/`super+Shift+w` | close/kill focused window                    |
| `super+g`                 | swap the current node and the biggest window |

#### Layout

| Key             | What it does                                     |
| --------------- | ------------------------------------------------ |
| `super+m`       | cycle between tiled and monocle layout (desktop) |
| `super+t`       | set window as tiled layout                       |
| `super+Shift+t` | set window as pseudo-tiled layout                |
| `super+s`       | set window as floating layout                    |
| `super+f`       | set window as fullscreen layout                  |

#### Flags & selection

| Key                      | What it does                                               |
| ------------------------ | ---------------------------------------------------------- |
| `super+Ctrl+m`           | set window as marked                                       |
| `super+Ctrl+x`           | set window as locked                                       |
| `super+Ctrl+y`           | set window as sticky                                       |
| `super+Ctrl+z`           | set window as private                                      |
| `super+y`                | send the newest marked node to the newest preselected node |
| `super+Ctrl+{h,j,k,l}`   | preselect direction (left/down/up/right)                   |
| `super+Ctrl+{1-9}`       | preselect ratio (size of window)                           |
| `super+Ctrl+Space`       | cancel preselection for the focused node                   |
| `super+Ctrl+Shift+Space` | cancel preselection for the current desktop                |

#### Focus & Swap

| Key                               | What it does                                                      |
| --------------------------------- | ----------------------------------------------------------------- |
| `super+{h,j,k,l}`                 | focus window at left/down/up/right                                |
| `super+Shift+{h,j,k,l}`           | swap with window at left/down/up/right                            |
| `super+Shift+Space`/`super+Space` | focus the previous/next window in the current desktop             |
| `super+[`/`super+]`               | focus previous/next desktop                                       |
| `super+{1-9,0}`                   | focus desktop 1-10                                                |
| `super+Shift+{1-9,0}`             | send current focused window at desktop 1-10                       |
| `super+p`/`super+n`               | focus the previous/next occupied desktop                          |
| `super+Shift+p`/`super+Shift+n`   | send current focused window at the previous/next occupied desktop |

#### Move & Resize

| Key                          | What it does                                 |
| ---------------------------- | -------------------------------------------- |
| `super+Alt+{h,j,k,l}`        | expand the window to left/down/up/right      |
| `super+Ctrl+Alt+{h,j,k,l}`   | contract the window at left/down/up/right    |
| `super+{Left,Down,Up,Right}` | move a floating window at left/down/up/right |
