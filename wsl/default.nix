{
  hostname,
  nixos-wsl,
  username,
  ...
}:
{
  imports = [
    nixos-wsl.nixosModules.default
    {
      system.stateVersion = "25.05";
      wsl = {
        enable = true;
        defaultUser = "${username}";
      };
    }
  ];
  networking.hostName = "${hostname}";
  programs.nix-ld.enable = true;
}
