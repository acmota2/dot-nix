{ pkgs, ... }:
{
  services = {
    open-webui.enable = true;
    ollama = {
      enable = true;
      # Optional: preload models, see https://ollama.com/library
      environmentVariables = {
        HCC_AMDGPU_TARGET = "gfx1036";
      };
      rocmOverrideGfx = "10.3.0";
      loadModels = [
        "llama3.2:3b"
        "codellama:7b"
        "qwen3:8b"
      ];
    };
  };
  environment.systemPackages = [ pkgs.ollama-rocm ];
  boot.initrd.kernelModules = [ "amdgpu" ];
}
