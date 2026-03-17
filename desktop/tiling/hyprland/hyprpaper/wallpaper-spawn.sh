#!/bin/sh

PICDIR="$HOME/pictures"
TIME=$(date +%H)

if [ "$TIME" -ge 7 ] && [ "$TIME" -lt 19 ]; then
  WLP=$(find "$PICDIR" -maxdepth 1 -name '*hot.jpg' | shuf -n 1)
else
  WLP=$(find "$PICDIR" -maxdepth 1 -name '*cold.jpg' | shuf -n 1)
fi

hyprctl hyprpaper wallpaper ",$WLP"
