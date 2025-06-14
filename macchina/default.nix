{ pkgs, home-manager, username, ... }:
{
	home-manager.users.${username} = _: { 
		home.file.".config/mako/config" = {
			source = ./.;
			recursive = true;
		};
		home.packages = with pkgs; [ mako ];
	};
}
