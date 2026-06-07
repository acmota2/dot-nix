{
  config,
  lib,
  ...
}:
lib.mkIf (config.hostSettings.display.adapter.manufacturer == "amd") {
  environment.variables.AMD_VULKAN_ICD = "RADV";
  hardware = {
    amdgpu.overdrive.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
