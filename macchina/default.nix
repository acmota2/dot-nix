{ pkgs, username, ... }: {
  home-manager.users.${username} = _: {
    home.file.".config/macchina" = {
      source = ./config;
      recursive = true;
    };
    home.packages = with pkgs; [ macchina ];
  };
}
