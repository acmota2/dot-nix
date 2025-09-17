{
  hostname ? "Squid",
  isHomeManager,
  myUtils,
  pkgs,
  username,
  ...
}:
myUtils.homeOrNixos {
  inherit isHomeManager username;
  options = {
    home.file.".config/macchina/macchina.toml".source = ./config/macchina.toml;
    home.file.".config/macchina/themes/main.toml".source = ./config/themes/main.toml;
    home.file.".config/macchina/themes/art.txt".source = ./config/themes/${hostname}.txt;
    home.packages = with pkgs; [ macchina ];
  };
}
