{
  isHomeManager,
  myUtils,
  username,
  ...
}:
myUtils.homeOrNixos {
  inherit isHomeManager username;
  options = {
    programs = {
      atuin.enableBashIntegration = true;
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          ls = "ls --color";
          als = "ls -la";
          cp = "cp -i";
          edit = "sudo -e";
          schlaf = "systemctl suspend";
          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../..";
        };
        historySize = 1000;
        historyFile = "~/.histfile";
      };
      readline = {
        enable = true;
        variables = {
          bell-style = "none";
          show-all-if-ambiguous = "on";
        };
        bindings = {
          "\\e[H" = "beginning-of-line"; # Home key
          "\\e[F" = "end-of-line"; # End key
          "\\e[3~" = "delete-char"; # Delete key
          "\\e[1;5C" = "forward-word"; # Ctrl+Right
          "\\e[1;5D" = "backward-word"; # Ctrl+Left
          "\\C-h?" = "backward-kill-word"; # Ctrl+Backspace
          "\\e[3;5~" = "kill-word"; # Ctrl+Del
          "\\C-i" = "menu-complete"; # Tab
          "\\e[Z" = "menu-complete-backward"; # Shift+Tab
        };
      };
    };
  };
}
