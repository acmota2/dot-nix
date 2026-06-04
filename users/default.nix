{ isHomeManager, ... }:
{
  imports = [
    (if isHomeManager then ./default/home-manager.nix else ./default)
    ./root/enable-ssh.nix
  ];
}
