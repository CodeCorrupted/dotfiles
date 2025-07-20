#!/usr/bin/env bash

set -euo pipefail

lock_guard() { pgrep -x i3lock && exit 0; }

shutdown="  Shutdown"
reboot="  Reboot"
lock="  Lock"
logout="  Logout"
yes="  Yes"
no="  No"

menu="${lock}\n${logout}\n${reboot}\n${shutdown}"

dmenu_cmd() {
  dmenu -i -l 4 -p "Power Menu: " -fn 'Hurmit Nerd Font' -nb '#1c1823' -nf '#dacecd' -sb '#3662CD' -sf '#dacecd'
}

confirm() {
  printf "%b" "${yes}\n${no}" | dmenu -i -l 2 -p "Confirm?"
}

chosen=$(printf "%b" "$menu" | dmenu_cmd) || exit 0

case "$chosen" in
"$shutdown" | "${shutdown}")
  action="--shutdown"
  ;;
"$reboot" | "${reboot}")
  action="--reboot"
  ;;
"$logout" | "${logout}")
  action="--logout"
  ;;
"$lock" | "${lock}")
  action="--lock"
  ;;
*) exit 0 ;;
esac

if [[ "$action" != "--lock" ]]; then
  answer=$(confirm) || exit 0
  [[ "$answer" != "$yes" ]] && exit 0
fi

case "$action" in
--shutdown)
  loginctl poweroff -i
  ;;
--reboot)
  loginctl reboot
  ;;
--logout)
  i3-msg exit
  ;;
--lock)
  lock_guard
  i3lock --image=/home/arc/Images/LockScreen/illust_121045114_20240801_170320.png
  ;;
esac
