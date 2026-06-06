#!/usr/bin/env bash
ACTION=$(printf "Lock\nLog Out\nSuspend\nReboot\nShut Down" | walker --dmenu)
case "$ACTION" in
  Lock)    hyprlock ;;
  "Log Out") hyprctl dispatch exit ;;
  Suspend) systemctl suspend ;;
  Reboot)  systemctl reboot ;;
  "Shut Down") systemctl poweroff ;;
esac
