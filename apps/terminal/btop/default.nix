{
  config,
  isHomeManager,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.hostSettings.enable (
  let
    utils = import ../../../utils { inherit lib; };
  in
  utils.homeOrNixos {
    inherit config isHomeManager;
    options = {
      home.packages = [ pkgs.btop ];
      programs.btop = {
        enable = true;
        themes.tokyonight = builtins.readFile ./themes/tokyonight.theme;
        settings = {
          color_theme = "tokyonight";
          theme_background = false;
        };
      };
    };
  }
)
