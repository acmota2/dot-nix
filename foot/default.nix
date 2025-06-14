{ pkgs, home-manager, username, ... }:
{
	home-manager.users.${username} = _: { 
		home = {
			file.".config/foot/foot.ini".source = ./foot.ini;
			packages = with pkgs; [ foot ];
		};
	};
}
