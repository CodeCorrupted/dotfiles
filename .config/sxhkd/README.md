# sxhkd

This file is used on bspwm to define the keyboard shortcuts for the window
manager.

The following is a list of the keyboard shortcuts configured in this file
(remember that "super" is for "window's key"):

## Applications

This are the only shortcuts that can be used on others window managers.

- `super + Return`: open Alacritty terminal.
- `super + d`: open Rofi (application launcher).
- `super + Escape`: reset sxhkd.
- `super + Supr`: launches the power menu.
- `super + i`: run qutebrowser.
- `super + shift + i`: run Vivaldi browser.
- `super + Print` or `super + s`: run scrot to take an screenshot and save it on
  `~/Images/Screenshots/`.
- `super + shift + Print` or `super + shift + s`: run scrot to take an screenshot
  of a section of the screen and save it on `~/Images/Screenshots/`.
- `super + Tab`: run Rofi to switch between open windows.
- Special keys to manage volume and bright are configured to run the scripts
  to do their tasks. Any of these increase or decrease at 5 percent step. For
  more info, go to the `.scripts` folder. Also you can use `super + v` to
  increase volume, `super + shift + v` to decrease volume and `super + alt + v`
  to mute. For bright, `super + b` increases it and `super + shift + b`
  decreases it
- `super + alt + r`: reset bspwm.

## Layouts

- `super + m`: switch to next layout.

## Windows (only bspwm)

### Actions on windows

- `super + w`: close the focused window.
- `super + shift + w`: kill the focused window.
- `super + t`: set the focused window as tiled.
- `super + shift + t`: set the focused window as pseudo-tiled.
- `super + s`: set the focused window as float.
- `super + f`: set the focused window as fullscreen.

### Focus

- `super + h`: switch focus to the window at the left.
- `super + j`: switch focus to the window at the bottom.
- `super + k`: switch focus to the window at the top.
- `super + l`: switch focus to the window at the right.
- `super + space`: switch focus with the next window.
- `super + shift + space`: switch focus with the previous window.

### Move

- `super + Left`: move the focused floating window to the left.
- `super + Up`: move the focused floating window to top.
- `super + Down`: move the focused floating window to the bottom.
- `super + Right`: move the focused floating window to the right.
- `super + shift + h`: switch places with the window at the left.
- `super + shift + j`: switch places with the window at the bottom.
- `super + shift + k`: switch places with the window at the top.
- `super + shift + l`: switch places with the window at the right.
- `super + shift + 1 - 0`: switch the focus window to desktop 1 - 10.
- `super + g`: switch places between focused window with the next biggest window.

### Resize

- `super + alt + h`: increase size of the window to the left.
- `super + alt + j`: increase size of the window to the bottom.
- `super + alt + k`: increase size of the window to top.
- `super + alt + l`: increase size of the window to the right.
- `super + ctrl + alt + h`: decrease size of the window by the left.
- `super + ctrl + alt + j`: decrease size of the window by the bottom.
- `super + ctrl + alt + k`: decrease size of the window by top.
- `super + ctrl + alt + l`: decrease size of the window by the right.

### Preselected

- `super + y`: send the most recent marked window to the newest preselected node
- `super + ctrl + m`: mark the focused window.
- `super + ctrl + x`: lock the focused window.
- `super + ctrl + y`: stick the focused window.
- `super + ctrl + z`: set as private the focused window.
- `super + ctrl + h`: preselect left side.
- `super + ctrl + j`: preselect top side.
- `super + ctrl + k`: preselect bottom side.
- `super + ctrl + l`: preselect right side.
- `super + ctrl + 1-9`: preselect ratio (size of the new node).
- `super + ctrl + space`: cancel the preselection for the focused node.
- `super + ctrl + shift + space`: cancel the preselection for the focused desktop.

## Workspaces (only bspwm)

- `super + 1 - 0`: switch to desktop 1 - 10.
- `super + [`: focus previous desktop in the current monitor.
- `super + ]`: focus next desktop in the current monitor.
- `super + n`: focus next occupied desktop.
- `super + p`: focus previous occupied desktop.
- `super + shift + n`: send focused window to the next occupied desktop.
- `super + shift + p`: send focused window to the previous occupied desktop.
