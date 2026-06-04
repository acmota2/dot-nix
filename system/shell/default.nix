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
      fzf.enable = true;
      starship.enable = true;
      zoxide = {
        enable = true;
        options = [ "--cmd cd" ];
      };
    };
  };
}
