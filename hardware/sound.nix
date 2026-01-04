{ pkgs, username, ... }:
{
  users.users.${username} = {
    extraGroups = [ "sound" ];
  };
  security.rtkit.enable = true;
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
