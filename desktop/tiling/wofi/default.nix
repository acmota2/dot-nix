{
  config,
  lib,
  meta,
  pkgs,
  ...
}:
let
  desktop = config.hostSettings.display.desktop.name;
in
lib.mkIf (meta.utils.isTiling desktop) {
  home-manager.users.${config.hostSettings.users.default.username} = _: {
    home = {
      file.".config/wofi/config".source = ./config;
      file.".config/wofi/style.css".source = ./style.css;
      packages = with pkgs; [ wofi ];
    };
  };
}
