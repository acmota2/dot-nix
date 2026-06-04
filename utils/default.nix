{ lib }:
{
  homeOrNixos =
    {
      config,
      isHomeManager,
      options,
      optionalHome ? { },
      optionalNixos ? { },
    }:
    lib.mkIf config.hostSettings.enable (
      if isHomeManager then
        lib.mkMerge [
          options
          optionalHome
        ]
      else
        {
          home-manager.users.${config.hostSettings.users.default.username} =
            _:
            lib.mkMerge [
              options
              optionalNixos
            ];
        }
    );
}
// (import ../modules/constants.nix).utils
