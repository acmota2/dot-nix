{
  config,
  lib,
  monitors,
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

  boot.kernelParams = map (
    m: "video=${m.output}:${toString m.width}x${toString m.height}MR@${toString m.refresh}Hz"
  ) monitors;
}
