{ config, ... }:
let
  defaultUser = config.hostSettings.users.default;
in
{
  programs.home-manager.enable = true;

  home.username = defaultUser.username;
  home.homeDirectory = "/home/${defaultUser.username}";
  home.stateVersion = "26.05"; # Update this when changing nixpkgs version

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  programs.git = {
    enable = true;
    settings = {
      aliases = {
        "ga" = "git add";
        "gc" = "git clone";
        user = {
          email = defaultUser.gitEmail;
          name = defaultUser.gitUser;
        };
      };
      diff = {
        tool = "nvimdiff";
      };
      difftool = {
        "nvimdiff" = {
          cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
        };
      };
      merge = {
        tool = "nvimdiff";
      };
      mergetool = {
        "nvimdiff" = {
          cmd = "nvim -d \"$LOCAL\" \"$BASE\" \"$REMOTE\" \"$MERGED\" -c 'wincmd J'";
        };
        prompt = false;
      };
      core = {
        editor = "nvim";
      };
    };
  };
}
