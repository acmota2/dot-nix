{
  config,
  lib,
  pkgs,
  ...
}@inputs:
let
  defaultUser = config.hostSettings.users.default;
in
lib.mkIf defaultUser.enable {
  users = {
    groups.${defaultUser.username} = { };
    users.${defaultUser.username} = {
      group = defaultUser.username;
      shell = pkgs.${defaultUser.shell};
      isNormalUser = true;
      extraGroups = [
        "audio"
        "ydotool"
        "wheel"
      ];
      inherit (defaultUser) description;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1Bu1KY2x3DGuvOGFhDh00BrXXddgatGno21uEtpOLu acmota2@EnderDragon"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJhL+Z4YaPU5hDtjjsl9HlKCUPekgGKMI3acWEGfffrp acmota2@Allay"
      ];
    };
  };

  home-manager = {
    backupFileExtension = "bak";
    users.${defaultUser.username} = _: (import ./home-manager.nix inputs);
  };
}
