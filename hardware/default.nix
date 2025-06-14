{ graphics, ... }:
{
    imports = [
      ./sound.nix
      ./network.nix
      ./${graphics}.nix
    ];
}
