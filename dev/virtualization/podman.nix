{ config, pkgs, ... }:
{
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.users.${config.hostSettings.users.default.username}.extraGroups = [
    "docker"
    "podman"
  ];

  environment.systemPackages = with pkgs; [
    dive
    docker-compose
    podman-tui
    podman-compose
  ];
}
