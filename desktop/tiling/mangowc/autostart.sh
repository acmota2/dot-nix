swaybg -i "$HOME/pictures/penide-cold.jpg" -m fill &

swayidle -w \
  timeout 290 'swaylock' \
  timeout 300 'mmsg -d disable_monitor,DP-1; mmsg -d disable_monitor,DP-2' \
  resume 'mmsg -d enable_monitor,DP-1; mmsg -d enable_monitor,DP-2 && brightnessctl -r' \
  timeout 1800 'systemctl suspend' \
  before-sleep 'swaylock'
