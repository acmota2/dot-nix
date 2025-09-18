{ isHomeManager, username, ... }:
{
  imports = if isHomeManager then [ ./${username}/home-manager.nix ] else [ ./${username} ];
}
