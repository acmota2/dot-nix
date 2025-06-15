{ pkgs, ... }:
{
  users.users."acmota2" = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "acmota2";
  };

  home-manager = {
    backupFileExtension = "bak";
    users."acmota2" = _: {
      programs = {
        zsh.enable = true;
        git = {
          enable = true;
          userName = "acmota2";
          userEmail = "acmota2@gmail.com";
          aliases = {
            "ga" = "git add";
          };
        };
        fzf = {
          enable = true;
          enableZshIntegration = true;
        };
        starship = {
          enable = true;
          enableZshIntegration = true;
        };
        zoxide = {
          enable = true;
          enableZshIntegration = true;
          options = [ "--cmd cd" ];
        };
      };
    };
  };
}

