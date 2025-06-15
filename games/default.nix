{ pkgs, ... }: {
  imports = [ ./minecraft ];
  environment.systemPackages = with pkgs; [ steam lutris ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}

