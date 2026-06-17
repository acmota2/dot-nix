{
  config,
  isHomeManager,
  meta,
  ...
}:
{
  imports = [
    ./bash.nix
    ./nushell.nix
  ];
}
// meta.utils.homeOrNixos {
  inherit config isHomeManager;
  options = {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      fzf = {
        enable = true;
        colors = {
          "bg+" = "#2f334d";
          "bg" = "#24283b";
          "spinner" = "#f7768e";
          "hl" = "#7aa2f7";
          "fg" = "#c0caf5";
          "header" = "#7aa2f7";
          "info" = "#bb9af7";
          "pointer" = "#7dcfff";
          "marker" = "#7dcfff";
          "fg+" = "#c0caf5";
          "prompt" = "#7aa2f7";
          "hl+" = "#7dcfff";
        };
      };
      starship.enable = true;
      zoxide = {
        enable = true;
        options = [ "--cmd cd" ];
      };
    };
  };
}
