{ nvidia, ... }:
{
    imports = let
        base = [
            ./sound.nix
            ./network.nix
        ];
        in if nvidia then
            base ++ [ ./nvidia.nix ]
        else
            base;
}
