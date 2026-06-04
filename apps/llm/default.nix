{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    aider-chat-full
  ];
  services = {
    open-webui = {
      enable = true;
      environment = {
        HOME = "/var/lib/open-webui";
        HUGGINGFACE_HUB_CACHE = "/var/lib/open-webui/cache/huggingface";
        TRANSFORMERS_CACHE = "/var/lib/open-webui/cache/transformers";
        CHROMA_CACHE_DIR = "/var/lib/open-webui/cache/chroma";
      };
      package = pkgs.open-webui;
      port = 10101;
    };
    ollama = {
      enable = true;
      package = pkgs.ollama-rocm;

      environmentVariables = {
        OLLAMA_KEEP_ALIVE = "30s";
        OLLAMA_NUM_PARALLEL = "1";
      };

      rocmOverrideGfx = "11.0.0";

      loadModels = [
        "qwen3:8b"
        "mistral-nemo"
        "gemma3:27b"
        "qwen3:30b"
      ];
    };
  };

  systemd.services.open-webui.serviceConfig = {
    Restart = "always";
    RestartSec = "5s";
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  users.users.${config.hostSettings.users.default.username}.extraGroups = [
    "video"
    "render"
  ];
}
