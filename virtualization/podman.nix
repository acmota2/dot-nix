{ pkgs, username, ... }:
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

  users.users.${username}.extraGroups = [
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
