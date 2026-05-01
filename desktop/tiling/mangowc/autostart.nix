{
  pkgs,
  monitors,
  isGaming,
}:
let
  # Generate commands for all connected monitors
  enableCmds = builtins.concatStringsSep "; " (
    map (m: "mmsg -d enable_monitor,${m.output}") monitors
  );
  disableCmds = builtins.concatStringsSep "; " (
    map (m: "mmsg -d disable_monitor,${m.output}") monitors
  );

  # Background/Inhibitor logic
  inhibitor = "${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit &";
  bg = "${pkgs.swaybg}/bin/swaybg -i $HOME/pictures/penide-cold.jpg -m fill &";
in
pkgs.writeShellScript "mango-autostart" ''
  ${inhibitor}

  ${if isGaming then "" else bg}

  ${pkgs.swayidle}/bin/swayidle -w \
    timeout 300 '${disableCmds}' \
    resume '${enableCmds}' \
    timeout 1800 'systemctl suspend' \
    before-sleep '${pkgs.swaylock-effects}/bin/swaylock'
''
