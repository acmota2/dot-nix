{
  config,
  isHomeManager,
  lib,
  meta,
  ...
}:
lib.mkIf (config.hostSettings.users.default.shell == "nushell") (
  meta.utils.homeOrNixos {
    inherit config isHomeManager;
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
            $env.EDITOR = "nvim"
            $env.VISUAL = "nvim"
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
)
