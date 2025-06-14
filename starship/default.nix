{ pkgs, home-manager, username, ... }:
{
	home-manager.users.${username} = _: { 
		home = {
			file.".config/starship.toml".source = ./starship.toml;
			packages = with pkgs; [ starship ];
		};
	};
}
