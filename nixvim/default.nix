{ nixvim, pkgs, ... }:
{
    imports = [
	nixvim.nixosModules.nixvim
    ];
    programs.nixvim.config = {
	enable = true;
        keymaps = import ./remaps.nix;
        opts = import ./options.nix;
        plugins = import ./plugins.nix;
        extraPlugins = with pkgs.vimPlugins; [ 
	        telescope-nvim
            	# falcon
        ];
        globals.mapleader = " ";
        colorschemes.tokyonight = {
           	enable = true;
            	settings.style = "night";
        };
	extraConfigLua = ''print("Let's code!")'';
    };
}
