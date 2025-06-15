{ username, pkgs, ... }: {
  home-manager.users.${username} = _: {
    home = {
      file.".config/wofi/config".source = ./config;
      file.".config/wofi/style.css".source = ./style.css;
      packages = with pkgs; [ wofi ];
    };
  };
}
