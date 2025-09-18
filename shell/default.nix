{
  isHomeManager,
  myUtils,
  username,
  ...
}:
myUtils.homeOrNixos {
  inherit isHomeManager username;
  options = {
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
        "..." = "cd ../..";
        "...." = "cd ../../..";
      };

      history = {
        size = 1000;
        path = "$HOME/.zsh_history";
      };
      initContent = ''
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
  };
}
