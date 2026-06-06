#!/usr/bin/env bash
ACTION=$(printf "🔒 Lock\n🚪 Log Out\n💤 Suspend\n🔁 Reboot\n⏬ Shut Down" | walker --dmenu)
case "$ACTION" in
"🔒 Lock") hyprlock ;;
"🚪 Log Out") hyprctl dispatch exit ;;
"💤 Suspend") systemctl suspend ;;
"🔁 Reboot") systemctl reboot ;;
"⏬ Shut Down") systemctl poweroff ;;
esac
