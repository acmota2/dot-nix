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
      atuin.enableNushellIntegration = true;
      nushell = {
        enable = true;
        shellAliases = {
          als = "ls -a";
          cp = "cp -i";
          edit = "sudo -e";
          schlaf = "systemctl suspend";
        };
        extraConfig = ''
          $env.config = {
            show_banner: false
          }
        '';
      };
      starship = {
        enable = true;
        enableNushellIntegration = true;
      };
      zoxide = {
        enable = true;
        enableNushellIntegration = true;
        options = [ "--cmd cd" ];
      };
    };
  };
}
