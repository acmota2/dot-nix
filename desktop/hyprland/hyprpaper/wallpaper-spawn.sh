#!/bin/sh

TIME=$(date +%H)

if [ $TIME -ge 7 ] && [ $TIME -lt 19 ]; then
    WLP=$(ls ~/pictures | grep hot | shuf -n 1)
else
    WLP=$(ls ~/pictures | grep cold | shuf -n 1)
fi

hyprctl hyprpaper preload ~/pictures/$WLP
hyprctl hyprpaper wallpaper ,~/pictures/$WLP
