{ isHomeManager, username, ... }:
let
  starshipConfig = {
    home.file.".config/starship.toml".source = ./starship.toml;
  };
in
if isHomeManager then
  starshipConfig
else
  {
    home-manager.users.${username} = _: starshipConfig;
  }
