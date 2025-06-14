{ pkgs, home-manager, username, ... }:
{
	home-manager.users.${username} = _: { 
		home.file.".config/foot/foot.ini" = {
			source = ./.;
			recursive = true;
		};
		home.packages = with pkgs; [ foot ];
	};
}
