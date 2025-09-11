{
  pkgs,
  gitEmail,
  gitUser,
  ...
}:
{
  users.users.acmota2 = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "A normal user";
  };

  home-manager = {
    backupFileExtension = "bak";
    users."acmota2" = _: {
      programs = {
        zsh.enable = true;
        git = {
          enable = true;
          userName = "${gitUser}";
          userEmail = "${gitEmail}";
          aliases = {
            "ga" = "git add";
            "gc" = "git clone";
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
