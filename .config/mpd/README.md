# MPD Configuration

A drop-in `mpd.conf` that keeps **PulseAudio compatibility** while adding
ReplayGain, Zeroconf and faster library updates.

## Quickstart

Clone this repo and then:

```sh
sudo pacman -S --needed mpd

# Copy the configuration
mkdir -p ~/.config/mpd
cp dotfiles/.config/mpd/mpd.conf ~/.config/mpd/

# Reload or initialize mpd
systemctl start mpd
# or
systemctl restart mpd
# or
pkill -USR1 mpd && mpd ~/.config/mpd/mpd.conf
```

## Directory layout assumed

| Path            | Content                            |
| --------------- | ---------------------------------- |
| `~/Music/`      | Your music files                   |
| `~/.config/mpd` | Config, logs, playlist, sticker DB |
