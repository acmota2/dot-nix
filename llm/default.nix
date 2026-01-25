{
  services = {
    open-webui.enable = true;
    ollama = {
      enable = true;
      # Optional: preload models, see https://ollama.com/library
      loadModels = [ "llama3.2:3b" ];
    };
  };
}
