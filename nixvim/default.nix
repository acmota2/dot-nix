{ nixvim, pkgs, ... }:
{
    imports = [
	nixvim.nixosModules.nixvim
    ];
    programs.nixvim = {
        enable = true;
        keymaps = import ./remaps.nix;
        options = import ./options.nix;
        plugins = import ./plugins.nix;
        extraPlugins = with pkgs.vimPlugins; [
            nerdtree 
	        telescope-nvim
            # falcon
        ];
        globals.mapleader = " ";
        colorschemes.tokyonight = {
            enable = true;
            style = "night";
        };
        extraConfigLua = ''print("Let's code!")'';
    };
}
