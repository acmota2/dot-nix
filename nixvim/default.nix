{ nixvim, ... }:
{
    imports = [
	nixvim.nixosModules.nixvim
    ];
    programs.nixvim.config = {
	enable = true;
        keymaps = import ./remaps.nix;
        opts = import ./options.nix;
        plugins = import ./plugins.nix;
        globals.mapleader = " ";
        colorschemes.tokyonight = {
           	enable = true;
            	settings.style = "night";
        };
	extraConfigLua = ''print("Let's code!")'';
    };
}
