{ pkgs, username, ... }: {
  home-manager.users.${username} = _: {
    home = {
      packages = with pkgs; [ starship ];
      file.".config/starship.toml".source = ./starship.toml;
    };
  };
}
