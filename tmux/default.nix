{ pkgs, home-manager, username, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = [
      pkgs.tmuxPlugins.tokyo-night-tmux
      pkgs.tmuxPlugins.sensible
    ];
  };

  home-manager.users.${username} = _: {
    home.file.".config/tmux/tmux.conf".source = ./tmux.conf;
  };
}
