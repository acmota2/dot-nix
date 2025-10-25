{ pkgs, ... }@inputs:
{
  users.users.acmota2 = {
    shell = pkgs.bash;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "André Mota";
  };

  home-manager = {
    backupFileExtension = "bak";
    users."acmota2" = _: (import ./home-manager.nix inputs);
  };
}
