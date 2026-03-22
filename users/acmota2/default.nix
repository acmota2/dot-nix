{ pkgs, shell, ... }@inputs:
{
  users.users.acmota2 = {
    shell = pkgs.${shell};
    isNormalUser = true;
    extraGroups = [
      "audio"
      "ydotool"
      "wheel"
    ];
    description = "André Mota";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1Bu1KY2x3DGuvOGFhDh00BrXXddgatGno21uEtpOLu acmota2@EnderDragon"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJhL+Z4YaPU5hDtjjsl9HlKCUPekgGKMI3acWEGfffrp acmota2@Allay"
    ];
  };

  home-manager = {
    backupFileExtension = "bak";
    users."acmota2" = _: (import ./home-manager.nix inputs);
  };
}
