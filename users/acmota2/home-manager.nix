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
        userEmail = "${gitEmail}";
        userName = "${gitUser}";
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
      aliases = {
        "ga" = "git add";
        "gc" = "git clone";
      }
      // userConfig;
    };
  };
}
