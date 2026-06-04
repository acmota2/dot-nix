{
  config,
  hostname,
  lib,
  nixos-wsl,
  username,
  ...
}:
{
  imports = [
    nixos-wsl.nixosModules.default
    {
      system.stateVersion = "26.05";
      wsl = {
        enable = true;
        defaultUser = username;
      };
    }
  ];

  config = lib.mkIf config.hostSettings.meta.isWsl {
    networking.hostName = hostname;
    programs.nix-ld.enable = true;
    home-manager.users.${username} = _: {
      home.sessionVariables.EDITOR = "nvim";
    };
  };
}
