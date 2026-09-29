{
  config,
  isHomeManager,
  lib,
  meta,
  pkgs,
  ...
}:
let
  llama-pkg = pkgs.llama-cpp-rocm;
  username = config.hostSettings.users.default.username;
in
lib.mkMerge [
  {
    environment.systemPackages = with pkgs; [
      aider-chat-full
      opencode
    ];

    sops.secrets."librechat-env" = {
      format = "dotenv";
      sopsFile = ../../secrets/librechat.env;
      owner = username;
    };

    virtualisation.oci-containers = {
      backend = "podman";
      containers.librechat-db = {
        image = "mongo:6.0";
        ports = [ "127.0.0.1:27017:27017" ];
        volumes = [ "librechat-db-data:/data/db" ];
      };
    };

    services = {
      librechat = {
        credentialsFile = config.sops.secrets."librechat-env".path;
        enable = true;
        env = {
          ALLOW_REGISTRATION = true;
          PORT = "3080";
          HOST = "127.0.0.1";
          MONGO_URI = "mongodb://127.0.0.1:27017/LibreChat";
        };
        settings = {
          version = "1.2.1";
          cache = true;

          endpoints = {
            custom = [
              {
                name = "llama.cpp";
                apiKey = "sk-no-key-required";
                baseURL = "http://127.0.0.1:8083/v1";

                models = {
                  fetch = true;
                  default = [ "gemma4-26b" ];
                };

                titleConvo = true;
                titleModel = "current_model"; # Reuses the conversation model to generate titles
              }
            ];
          };
        };
      };

      llama-swap = {
        enable = true;
        port = 8083;
        settings = {
          logging.level = "info";
          performance.disabled = true;

          models = {
            "gemma4-26b" = {
              cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/gemma-4-26B-A4B-it-UD-IQ4_XS.gguf -ngl -1 --jinja -ctk q8_0 -ctv q8_0 -c 49152";
              ttl = 10;
            };
            "gemma4-31b" = {
              cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/gemma-4-31B-it-IQ4_XS.gguf -ngl -1 --jinja -ctk q8_0 -ctv q8_0 -c 16384";
              ttl = 10;
            };
            "mistral-nemo" = {
              cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/Mistral-Nemo-Prism-12B-Q8_0.gguf -ngl -1 -c 16384";
              ttl = 90;
            };
            "qwen3.5-4b" = {
              cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/Qwen3.5-4B-Q8_0.gguf -ngl -1 -c 16384";
              ttl = 90;
            };
            "qwen3.6-35b" = {
              cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/Qwen3.6-35B-A3B-UD-IQ4_XS.gguf -ngl -1 --jinja -ctk q8_0 -ctv q8_0 -c 32768";
              ttl = 10;
            };
            "qwen3.8-27b" = {
              # --reasoning-budget 2048 prevents overthinking while preserving quality
              cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/Qwen3.8-27B-UD-IQ4_XS.gguf -ngl -1 --jinja -ctk q8_0 -ctv q8_0 -c 40960 --reasoning-budget 2048 --temp 0.6 --top-p 0.95";
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

  (meta.utils.homeOrNixos {
    inherit config isHomeManager;
    options.xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
      "$schema" = "https://opencode.ai/config.json";
      model = "llama-swap/qwen3.8-27b";
      provider = {
        llama-swap = {
          npm = "@ai-sdk/openai-compatible";
          name = "llama-swap";
          options = {
            baseURL = "http://127.0.0.1:8083/v1";
            apiKey = "ignored";
          };
        };
      };
    };
  })
]
