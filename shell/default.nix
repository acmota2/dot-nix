{ pkgs, ... }:
{
  system.userActivationScripts.zshrc = "touch .zshrc";
  environment.shells = [ pkgs.zsh ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "ls --color";
      als = "ls -la";
      cp = "cp -i";
      edit = "sudo -e";
      schlaf = "systemctl suspend";
      ".." = "cd ..";
      "..." =  "cd ../..";
      "...." = "cd ../../..";
    };

    histSize = 1000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
    interactiveShellInit = ''
      zstyle ':completion:*' menu select

      bindkey  "^[[H"   beginning-of-line
      bindkey  "^[[F"   end-of-line
      bindkey  "^[[3~"  delete-char
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey '^H' backward-kill-word
      bindkey '5~' kill-word
      bindkey '^[[Z' reverse-menu-complete

      unsetopt BEEP
    '';
  };
}
