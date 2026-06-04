{
  config,
  isHomeManager,
  lib,
  ...
}:
lib.mkIf config.hostSettings.enable (
  let
    utils = import ../../../utils { inherit lib; };
  in
  utils.homeOrNixos {
    inherit config isHomeManager;
    options = {
      home.file.".config/starship.toml".source = ./starship.toml;
    };
  }
)
