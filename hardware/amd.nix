_: {
  environment.variables.AMD_VULKAN_ICD = "RADV";
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
