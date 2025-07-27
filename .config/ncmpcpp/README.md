# Ncmpcpp Configuration

A clean, column-oriented setup for **ncmpcpp** (the ncurses MPD client).

It includes:

- Real-time spectrum visualizer
- Desktop notifications on track change (requires `mpdnotify.conf` of this repo)
- Regex-powered search
- Sane navigations defaults

## Quickstart

Clone this repo and then:

```sh
# Install
sudo pacman -S --needed mpd ncmpcpp

# Copy
mkdir -p ~/.config/ncmpcpp/
cp dotfiles/mpdnotify.conf ~/.config/
cp dotfiles/ncmpcpp/config ~/.config/ncmpcpp
```

Reload `mpd` and launch `ncmpcpp`.

Your folder of music must be named as `Music`, on your home directory. If the
location of your music isn't that, you can change the directory where `ncmpcpp`
search for them on line 34.
