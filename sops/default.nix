{ sops-nix, ... }:
{
  imports = [ sops-nix.nixosModules.sops ];
  sops = {
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };
}
