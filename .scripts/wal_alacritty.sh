#!/usr/bin/env bash
# pywal2alacritty – drop-in replacement
set -euo pipefail

die() {
  printf 'ERR: %s\n' "$1" >&2
  exit 1
}

SRC="${HOME}/.cache/wal/colors.sh"
[[ -r $SRC ]] || die "wal cache not found – run 'wal -i <img>' first"

CFG="${1:-${HOME}/.config/alacritty/alacritty.toml}"
[[ -f $CFG ]] || die "config file not found: $CFG"

# follow symlink once
CFG=$(readlink -f "$CFG")

# load wal colours
FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:-}"
# shellcheck disable=SC1090
source "$SRC"

tmp=$(mktemp) && trap 'rm -f "$tmp"' EXIT

# delete old block if it exists
if grep -q '^# BEGIN WAL' "$CFG"; then
  awk '/^# BEGIN WAL/{p=1;print;next} /^# END WAL/{p=0;print;next} !p' "$CFG" >"$tmp"
else
  cp "$CFG" "$tmp"
fi

# append new block
cat >>"$tmp" <<EOF
# BEGIN WAL
[colors.primary]
background = '$color0'
foreground = '$color7'

[colors.cursor]
text   = '$color0'
cursor = '$color7'

[colors.vi_mode_cursor]
text   = '$color0'
cursor = '$color7'

[colors.search.matches]
foreground = '$color0'
background = '$color15'

[colors.search.focused_match]
foreground = 'CellBackground'
background = 'CellForeground'

[colors.line_indicator]
foreground = 'None'
background = 'None'

[colors.footer_bar]
foreground = '$color8'
background = '$color7'

[colors.selection]
text       = 'CellBackground'
background = 'CellForeground'

[colors.normal]
black   = '$color0'
red     = '$color1'
green   = '$color2'
yellow  = '$color3'
blue    = '$color4'
magenta = '$color5'
cyan    = '$color6'
white   = '$color7'

[colors.bright]
black   = '$color8'
red     = '$color9'
green   = '$color10'
yellow  = '$color11'
blue    = '$color12'
magenta = '$color13'
cyan    = '$color14'
white   = '$color15'
# END WAL
EOF

# atomic move
mv "$tmp" "$CFG"
printf '%s → %s\n' "$SRC" "$CFG"
