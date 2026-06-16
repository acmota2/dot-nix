{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = [
      pkgs.tmuxPlugins.tokyo-night-tmux
      pkgs.tmuxPlugins.sensible
    ];
  };

  home-manager.users.${config.hostSettings.users.default.username} = _: {
    xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
  };
}
