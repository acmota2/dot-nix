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
{
  config =
    lib.mkIf (meta.utils.isTiling desktop && (!config.hostSettings.display.desktop.noctalia.enable))
      {
        home-manager.users.${config.hostSettings.users.default.username} = _: {
          home = {
            file.".config/mako/config".source = ./config;
            packages = with pkgs; [ mako ];
          };
        };
      };
}
