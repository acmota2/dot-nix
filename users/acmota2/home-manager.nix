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
  programs.git = {
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
