{
  isHomeManager,
  myUtils,
  username,
  ...
}:
myUtils.homeOrNixos {
  inherit isHomeManager username;
  options = {
    home.file.".config/starship.toml".source = ./starship.toml;
  };
}
