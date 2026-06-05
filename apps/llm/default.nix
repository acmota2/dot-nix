{ config, pkgs, ... }:
let
  llama-pkg = pkgs.llama-cpp-rocm;
  username = config.hostSettings.users.default.username;
in
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

        OPENAI_API_BASE_URL = "http://127.0.0.1:8083/v1";
        OPENAI_API_KEY = "ignored"; # change to sops if I ever use it
        ENABLE_OLLAMA_API = "False";
      };
      package = pkgs.open-webui;
      port = 10101;
    };

    llama-swap = {
      enable = true;
      port = 8083;
      settings = {
        logging.level = "info";
        performance.disabled = true;

        models = {
          "gemma-4-12b" = {
            cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/gemma-4-12b-it-Q8_0.gguf -ngl -1 -c 32768";
            ttl = 10;
          };
          "gemma4-26b" = {
            cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/gemma-4-26B-A4B-it-Q4_K_M.gguf -ngl 36 -c 16384";
            ttl = 10;
          };
          "mistral-nemo" = {
            cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/Mistral-Nemo-Prism-12B-Q8_0.gguf -ngl -1 -c 32768";
            ttl = 10;
          };
          "qwen3.5-27b" = {
            cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/Qwen3.5-27B-Q4_K_M.gguf -ngl -1 -c 3072";
            ttl = 10;
          };
        };
      };
    };
  };

  systemd = {
    services.llama-swap = {
      environment = {
        HSA_OVERRIDE_GFX_VERSION = "11.0.0";
      };
      serviceConfig = {
        PrivateDevices = false;
        DeviceAllow = [
          "/dev/dri/renderD128"
          "/dev/dri/card0"
          "/dev/kfd"
        ];
        BindReadOnlyPaths = [ "/run/opengl-driver" ];
      };
    };

    tmpfiles.rules = [
      "d /var/lib/llama-models 0775 ${username} root - -"
    ];
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.graphics.enable = true;

  users.users.${username}.extraGroups = [
    "video"
    "render"
  ];
}
