{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (config.hostSettings.display.adapter.manufacturer == "amd") {
  environment.variables.AMD_VULKAN_ICD = "RADV";
  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-smi
  ];
  hardware = {
    amdgpu.overdrive.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
