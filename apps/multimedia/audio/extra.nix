{ musnix, pkgs, ... }:
let
  pd-packs = pkgs.writeShellScriptBin "pd-packs" ''
    exec ${
      pkgs.puredata-with-plugins [
        pkgs.cyclone
        pkgs.maxlib
        pkgs.zexy
      ]
    }/bin/pd \
      -lib zexy \
      -lib cyclone \
      "$@"
  '';
in
{
  imports = [ musnix.nixosModules.musnix ];

  musnix = {
    enable = true;
    kernel.packages = pkgs.linuxPackages_latest;
  };

  services.pipewire = {
    enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dexed
    lilypond
    muse-sounds-manager
    odin2
    pd-packs
    puredata
    reaper
    wineWowPackages.stable
    yabridge
    yabridgectl
  ];
}
