{
  lib,
  pkgs,
  ...
}@inputs:
let
  enable-nix-ld = builtins.hasAttr "enable-nix-ld" inputs;
  withNixLd = (
    lib.attrsets.optionalAttrs enable-nix-ld {
      programs.nix-ld.enable = "conditional_value";
    }
  );
in
{
  environment.systemPackages = with pkgs; [
    commitizen
    ripgrep
  ];
}
// withNixLd
