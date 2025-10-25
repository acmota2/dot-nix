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
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  programs = {
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
      enableBashIntegration = true;
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
