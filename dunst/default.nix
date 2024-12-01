{ pkgs, home-manager, username, ... }:
{
	home-manager.users.${username} = _: { 
		home.file.".config/dunst" = {
			source = ./.;
			recursive = true;
		};
		home.packages = with pkgs; [ dunst ];
	};
}
