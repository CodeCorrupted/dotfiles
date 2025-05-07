#!/usr/bin/env bash

set -euo pipefail

shutdown="  Shutdown"
reboot="  Reboot"
lock="  Lock"
logout="  Logout"
yes="  Yes"
no="  No"

menu="${lock}\n${logout}\n${reboot}\n${shutdown}"

dmenu_cmd() {
  dmenu -i -l 4 -p "Power Menu: " -fn 'Hurmit Nerd Font' -nb '#0f0e1c' -nf '#a6d5d6' -sb '#29779A' -sf '#a6d5d6'
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
  i3lock --image=/home/arc/Images/LockScreen/b53428fb-2a6f-4844-b76b-2ba20ce006eb.png
  ;;
esac
