{
  isHomeManager,
  myUtils,
  pkgs,
  username,
  ...
}:
myUtils.homeOrNixos {
  inherit isHomeManager username;
  options = {
    home.packages = [ pkgs.btop ];
    programs.btop = {
      enable = true;
      themes.tokyonight = builtins.readFile ./themes/tokyonight.theme;
      settings.color_theme = "tokyonight";
    };
  };
}
