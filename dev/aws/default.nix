{
  config,
  isHomeManager,
  lib,
  pkgs,
  ...
}:
let
  utils = import ../../utils { inherit lib; };
in
utils.homeOrNixos {
  inherit config isHomeManager;
  options = {
    home.sessionVariables = {
      AWS_VAULT_BACKEND = "pass";
      GPG_TTY = "$TTY";
    };

    home.packages = with pkgs; [
      awscli2
      aws-vault
      pass
    ];

    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-curses;
    };
  };
}
