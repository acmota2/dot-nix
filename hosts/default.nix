{
  config,
  hostname,
  lib,
  ...
}:
let
  # shorthands
  hostSettings = config.hostSettings;
  adapterSettings = hostSettings.adapter;

  # modules
  adapterModules =
    lib.optionals adapterSettings.enable [ (import ../hardware/${adapterSettings.manufacturer}) ]
    ++ [ (import ../desktop/${hostSettings.desktop}) ];

  laptopModules = lib.optionals hostSettings.hardware.isLaptop [
    ../hardware/tlp.nix
    ../hardware/brightness.nix
  ];
in
(import ./hostnames/${hostname}.nix { defaultModules = import ../.; })
++ adapterModules
++ laptopModules
