{ sops-nix, ... }:
{
  imports = [ sops-nix.nixosModules.sops ];
  sops = {
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/key.txt";
  };
}
