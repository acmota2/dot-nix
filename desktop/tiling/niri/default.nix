{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (config.hostSettings.display.desktop.name == "niri") {
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    swayidle
    swaylock-effects
    slurp
    grim
  ];

  security.pam.services.swaylock = { };

  home-manager.users.${config.hostSettings.users.default.username} = _: {
    home.file."config/niri/config.kdl".source = ./niri.kdl;
  };
}
