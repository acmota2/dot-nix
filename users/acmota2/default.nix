{ pkgs, shell, ... }@inputs:
{
  users.users.acmota2 = {
    shell = pkgs.${shell};
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
    ];
    description = "André Mota";
  };

  home-manager = {
    backupFileExtension = "bak";
    users."acmota2" = _: (import ./home-manager.nix inputs);
  };
}
