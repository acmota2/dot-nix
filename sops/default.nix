{ sops-nix, username, ... }:
{
  imports = [ sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

  sops.secrets.git-config = {
    format = "ini";
    owner = "${username}";
    sopsFile = ../secrets/git-config.ini;
  };
}
