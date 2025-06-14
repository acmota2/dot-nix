{ pkgs, ... }:
{
  hardware = {
    graphics = {
      extraPackages = with pkgs; [
        amdvlk
      ];
      enable = true;
      enable32Bit = true;
    };

    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };
}
