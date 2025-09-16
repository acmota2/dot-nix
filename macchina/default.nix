{
  hostname ? "Squid",
  isHomeManager,
  pkgs,
  username,
  ...
}:
let
  macchinaConfig = {
    home.file.".config/macchina/macchina.toml".source = ./config/macchina.toml;
    home.file.".config/macchina/themes/main.toml".source = ./config/themes/main.toml;
    home.file.".config/macchina/themes/art.txt".source = ./config/themes/${hostname}.txt;
    home.packages = with pkgs; [ macchina ];
  };
in
if isHomeManager then
  macchinaConfig
else
  {
    home-manager.users.${username} = _: macchinaConfig;
  }
