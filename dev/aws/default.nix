{
  isHomeManager,
  myUtils,
  pkgs,
  username,
  ...
}:
myUtils.homeOrNixos {
  inherit isHomeManager username;
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
