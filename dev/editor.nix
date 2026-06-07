{ my-nixvim, ... }:
{
  imports = [
    my-nixvim.nixosModules.my-nixvim
  ];

  programs.my-nixvim = {
    enable = true;
    settings.enable = true;
  };
}
