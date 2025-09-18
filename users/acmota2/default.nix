{ pkgs, ... }@inputs:
{
  users.users.acmota2 = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "A normal user";
  };

  programs.zsh.enable = true;

  home-manager = {
    backupFileExtension = "bak";
    users."acmota2" = _: (import ./home-manager.nix inputs);
  };
}
