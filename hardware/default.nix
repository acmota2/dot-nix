{ graphics, ... }:
{
  imports = [
    ./sound.nix
    ./network.nix
    ./${graphics}.nix
  ];
  hardware.keyboard.qmk.enable = true;
}
