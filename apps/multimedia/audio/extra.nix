{ musnix, pkgs, ... }:
let
  pd-packs = pkgs.writeShellScriptBin "pd-packs" ''
    exec ${
      pkgs.puredata-with-plugins [
        pkgs.zexy
        pkgs.cyclone
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
    lilypond
    muse-sounds-manager
    puredata
    pd-packs
    reaper
  ];
}
