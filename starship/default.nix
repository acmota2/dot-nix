{ username, ... }: {
  home-manager.users.${username} = _: {
    home.file.".config/starship.toml".source = ./starship.toml;
  };
}
