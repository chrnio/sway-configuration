#!/bin/sh

DIR="$HOME/Pictures/Screenshots"
FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

mkdir -p "$DIR"

case "$1" in
area)
  grim -g "$(slurp)" "$FILE" &&
    notify-send -t 2000 "Screenshot saved"
  ;;

fullscreen)
  grim "$FILE" &&
    notify-send -t 2000 "Screenshot saved"
  ;;

clipboard)
  grim -g "$(slurp)" - |
    wl-copy &&
    notify-send -t 2000 "Screenshot copied"
  ;;

window)
  swaymsg -t get_tree |
    jq -r '.. | select(.focused? == true).rect |
                "\(.x),\(.y) \(.width)x\(.height)"' |
    grim -g - "$FILE" &&
    wl-copy <"$FILE" &&
    notify-send -t 2000 "Window screenshot saved"
  ;;
esac
