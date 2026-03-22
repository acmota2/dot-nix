{
  gitUser,
  gitEmail,
  ...
}:
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
          user = {
            email = "${gitEmail}";
            name = "${gitUser}";
          };
        };
      };
    };
  };
}
