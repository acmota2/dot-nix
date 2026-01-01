{
  isHomeManager,
  myUtils,
  shell,
  username,
  ...
}:
{
  imports = [ ./${shell}.nix ];
}
// myUtils.homeOrNixos {
  inherit isHomeManager username;
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
