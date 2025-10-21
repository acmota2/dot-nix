{
  config,
  gitUser,
  gitEmail,
  ...
}:
let
  userConfig =
    if gitUser != null && gitEmail != null then
      {
        email = "${gitEmail}";
        name = "${gitUser}";
      }
    else
      {
        extraConfig.include.path = config.sops.secrets.git-config.path;
      };
in
{
  programs = {
    zsh.enable = true;
    git = {
      enable = true;
      settings = {
        aliases = {
          "ga" = "git add";
          "gc" = "git clone";
        };
        user = userConfig;
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
}
