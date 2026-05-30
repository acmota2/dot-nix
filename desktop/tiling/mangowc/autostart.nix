{
  pkgs,
  monitors,
}:
let
  enableCmds = builtins.concatStringsSep "; " (
    map (m: "mmsg -d enable_monitor,${m.output}") monitors
  );
  disableCmds = builtins.concatStringsSep "; " (
    map (m: "mmsg -d disable_monitor,${m.output}") monitors
  );
in
pkgs.writeShellScript "mango-autostart" ''
  ${pkgs.swaybg}/bin/swaybg -i $HOME/pictures/penide-cold.jpg -m fill &

  ${pkgs.swayidle}/bin/swayidle -w \
    timeout 1200 '${disableCmds}' \
    resume '${enableCmds}' \
    timeout 1800 'systemctl suspend' \
    before-sleep '${pkgs.swaylock-effects}/bin/swaylock'
''
