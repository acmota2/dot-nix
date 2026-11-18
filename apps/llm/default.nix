{
  config,
  isHomeManager,
  lib,
  meta,
  pkgs,
  unstable,
  ...
}:
let
  llama-pkg = pkgs.llama-cpp-rocm;
  username = config.hostSettings.users.default.username;
in
lib.mkMerge [
  {
    environment.systemPackages = with pkgs; [
      aider-chat
      unstable.opencode
    ];

    sops.secrets."librechat-env" = {
      format = "dotenv";
      sopsFile = ../../secrets/librechat.env;
      owner = username;
    };

    virtualisation.oci-containers = {
      backend = "podman";
      containers = {
        librechat-db = {
          image = "mongo:6.0";
          ports = [ "127.0.0.1:27017:27017" ];
          volumes = [ "librechat-db-data:/data/db" ];
        };

        librechat-meilisearch = {
          image = "getmeili/meilisearch:v1.5.0";
          ports = [ "127.0.0.1:7700:7700" ];
          environmentFiles = [ config.sops.secrets."librechat-env".path ];
          environment = {
            MEILI_NO_ANALYTICS = "true";
            MEILI_MASTER_KEY = "$MEILISEARCH_MASTER_KEY";
          };
          volumes = [ "librechat-meili-data:/meili_data" ];
        };

        # Add SearXNG for local web search
        librechat-searxng = {
          image = "docker.io/searxng/searxng:latest";
          ports = [ "127.0.0.1:8888:8080" ];
          environment = {
            SEARXNG_BASE_URL = "http://127.0.0.1:8888/";
          };
        };
      };
    };

    services = {
      librechat = {
        credentialsFile = config.sops.secrets."librechat-env".path;
        enable = true;
        package = unstable.librechat;
        env = {
          ALLOW_REGISTRATION = true;
          PORT = "3080";
          HOST = "127.0.0.1";
          MONGO_URI = "mongodb://127.0.0.1:27017/LibreChat";

          # RAG settings
          RAG_ENABLED = "true";
          MEILISEARCH_URL = "http://127.0.0.1:7700";

          # Local embeddings provider for RAG (can use llama.cpp's embedding endpoint)
          RAG_EMBEDDING_PROVIDER = "openai";
          RAG_EMBEDDING_MODEL = "text-embedding-ada-002"; # or a local embedding model served via llama-swap
          OPENAI_EMBEDDING_BASE_URL = "http://127.0.0.1:8083/v1";
          OPENAI_EMBEDDING_API_KEY = "sk-no-key-required";

          # File uploads storage
          UPLOAD_STORAGE_PATH = "/var/lib/librechat/uploads";

          # Web Search (SearXNG) settings
          SEARCH_PROVIDER = "searxng";
          SEARXNG_QUERY_URL = "http://127.0.0.1:8888/search?q=<query>";
          # Enable the web search toggle directly in the UI
          ENABLE_WEB_SEARCH = "true";
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
                  fetch = false;
                  default = [
                    "gemma4-26b"
                    "qwen3.6-35b"
                    "qwen3.8-27b"
                  ];
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
              cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/gemma-4-26B-A4B-it-UD-IQ4_XS.gguf -ngl -1 --jinja -ctk q4_0 -ctv q4_0 -c 81920";
              ttl = 10;
            };
            "gemma4-31b" = {
              cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/gemma-4-31B-it-IQ4_XS.gguf -ngl -1 --jinja -ctk q4_0 -ctv q4_0 -c 32768";
              ttl = 10;
            };
            "qwen3.6-35b" = {
              cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/Qwen3.6-35B-A3B-UD-IQ4_XS.gguf -ngl -1 --jinja -ctk q4_0 -ctv q4_0 -c 32768";
              ttl = 10;
            };
            "qwen3.8-27b" = {
              cmd = "${llama-pkg}/bin/llama-server --port \${PORT} -m /var/lib/llama-models/Qwen3.8-27B-UD-IQ4_XS.gguf -ngl -1 -fa 1 -ctk q4_0 -ctv q4_0 -c 49152 --jinja";
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
        "d /var/lib/librechat 0770 ${username} root - -"
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
      theme = "system";
      model = "llama-swap/qwen3.6-35b";
      provider = {
        llama-swap = {
          npm = "@ai-sdk/openai-compatible";
          name = "llama-swap";
          options = {
            baseURL = "http://127.0.0.1:8083/v1";
            apiKey = "sk-no-key-required";
          };
          models = {
            "qwen3.8-27b" = {
              name = "Qwen 3.8 27B (Local)";
            };
            "qwen3.6-35b" = {
              name = "Qwen 3.6 35B (Local)";
            };
            "gemma4-26b" = {
              name = "Gemma 4 26B (Local)";
            };
          };
        };
      };
    };
  })
]
