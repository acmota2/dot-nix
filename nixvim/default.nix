{ nixvim, pkgs, ... }:
{
    imports = [
	nixvim.nixosModules.nixvim
    ];
    programs.nixvim.config = {
	enable = true;
        keymaps = import ./remaps.nix;
        options = import ./options.nix;
        plugins = import ./plugins.nix;
        extraPlugins = with pkgs.vimPlugins; [ 
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
