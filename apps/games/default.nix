{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    steam
    # lutris-free
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
