# Picom Configuration

Minimal, **GPU-accelerated** compositor setup with:

- **Dual-kawase blur** on transparent windows.
- **Selective shadows & rounded corners**
- **Smooth animations** for open/close, menus, notifications.
- **Opacity rules** for terminals, file-managers, rofi, etc.

## Quickstart

Clone this repo and then:

```sh
# Install picom
sudo pacman -S --needed picom

# Copy this config
mkdir -p ~/.config/picom
cp dotfiles/.config/picom/picom.conf ~/.config/picom/

# Launch picom
picom -b
```
