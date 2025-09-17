{ username, ... }:
{
  homeOrNixos =
    {
      isHomeManager,
      options,
      optionalHome ? { },
      optionalNixos ? { },
    }:
    if isHomeManager then
      options // optionalHome
    else
      { home.users.${username} = _: options // optionalNixos; };
}
