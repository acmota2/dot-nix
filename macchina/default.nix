{
  pkgs,
  username,
  hostname,
  ...
}:
{
  home-manager.users.${username} = _: {
    home.file.".config/macchina/macchina.toml".source = ./config/macchina.toml;
    home.file.".config/macchina/theme/main.toml".source = ./config/themes/main.toml;
    home.file.".config/macchina/theme/art.txt".source = ./config/themes/${hostname}.txt;
    home.packages = with pkgs; [ macchina ];
  };
}
