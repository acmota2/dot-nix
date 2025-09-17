{ lib }:
{
  homeOrNixos =
    {
      isHomeManager,
      username,
      options,
      optionalHome ? { },
      optionalNixos ? { },
    }:
    if isHomeManager then
      lib.mkMerge [
        options
        optionalHome
      ]
    else
      {
        home-manager.users.${username} =
          _:
          lib.mkMerge [
            options
            optionalNixos
          ];
      };
}
