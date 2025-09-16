{
  isHomeManager,
  pkgs,
  nixvim,
  ...
}@inputs:
{
  imports = if isHomeManager then [ nixvim.homeModules.nixvim ] else [ nixvim.nixosModules.nixvim ];
  programs.nixvim = {
    enable = true;
    diagnostic.settings = {
      virtual_lines.current_line = true;
      virtual_text = true;
    };
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
