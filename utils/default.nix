{ lib }:
{
  homeOrNixos =
    {
      config,
      options,
      optionalHome ? { },
      optionalNixos ? { },
    }:
    if config.meta.isHomeManager then
      lib.mkMerge [
        options
        optionalHome
      ]
    else
      {
        home-manager.users.${config.users.defaultUser} =
          _:
          lib.mkMerge [
            options
            optionalNixos
          ];
      };
}
