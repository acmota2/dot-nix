{ pkgs, nixvim, ... }@inputs:
{
  imports = [ nixvim.nixosModules.nixvim ];
  programs.nixvim = {
    enable = true;
    globals.mapleader = ",";
    keymaps = import ./remaps.nix;
    opts = import ./options.nix;
    plugins = import ./plugins.nix inputs;
    colorschemes.tokyonight = {
      enable = true;
      settings.style = "night";
    };
    extraConfigLua = ''print("Let's code!")'';
    extraPackages = with pkgs; [
      nixfmt-rfc-style
      prettierd
      isort
    ];
  };
}
