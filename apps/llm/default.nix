{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    aider-chat-full
  ];
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
      package = pkgs.ollama-rocm;
      environmentVariables = {
        HIP_VISIBLE_DEVICES = "0";
        HSA_OVERRIDE_GFX_VERSION = "10.3.0";
        OLLAMA_KEEP_ALIVE = "30s";
        OLLAMA_NUM_PARALLEL = "2";
      };

      rocmOverrideGfx = "10.3.0";
      acceleration = "rocm";

      loadModels = [
        "qwen3:8b"
        "mistral-nemo"
      ];
    };
  };

  systemd.services.open-webui.serviceConfig = {
    Restart = "always";
    RestartSec = "5s";
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  users.users.${username}.extraGroups = [
    "video"
    "render"
  ];
}
