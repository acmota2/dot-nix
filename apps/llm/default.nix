{ pkgs, username, ... }:
{
  services = {
    open-webui.enable = true;
    ollama = {
      enable = true;
      # Optional: preload models, see https://ollama.com/library
      environmentVariables = {
        HSA_OVERRIDE_GFX_VERSION = "10.3.0";
      };
      rocmOverrideGfx = "10.3.0";
      acceleration = "rocm";
      loadModels = [
        "llama3.2:3b"
        "codellama:7b"
        "qwen3:8b"
      ];
    };
  };
  environment.systemPackages = [ pkgs.ollama-rocm ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Ensure your user has access to the render and video groups
  users.users.${username}.extraGroups = [
    "video"
    "render"
  ];
}
