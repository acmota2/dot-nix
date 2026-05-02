{ pkgs, username, ... }:
{
  services = {
    open-webui = {
      enable = true;
      port = 10101;
      environment = {
        HOME = "/var/lib/open-webui";
        HUGGINGFACE_HUB_CACHE = "/var/lib/open-webui/cache/huggingface";
        TRANSFORMERS_CACHE = "/var/lib/open-webui/cache/transformers";
        CHROMA_CACHE_DIR = "/var/lib/open-webui/cache/chroma";
      };
    };
    ollama = {
      enable = true;
      # Optional: preload models, see https://ollama.com/library
      package = pkgs.ollama-vulkan;
      loadModels = [
        "llama3.2:3b"
        "codellama:7b"
        "qwen3:8b"
      ];
    };
  };

  # Keep this separate block to maintain the aggressive restart policy
  systemd.services.open-webui.serviceConfig = {
    Restart = "always";
    RestartSec = "5s";
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  # Ensure your user has access to the render and video groups
  users.users.${username}.extraGroups = [
    "video"
    "render"
  ];
}
