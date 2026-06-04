{
  config,
  hostname ? "Squid",
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
      home.packages = with pkgs; [ macchina ];
    };
    optionalNixos = {
      home.file.".config/macchina/macchina.toml".source = ./config/macchina.toml;
      home.file.".config/macchina/themes/main.toml".source = ./config/themes/main.toml;
      home.file.".config/macchina/themes/art.txt".source = ./config/themes/${hostname}.txt;
    };
  }
)
