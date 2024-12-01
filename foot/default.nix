{ home-manager, username, pkgs, ...}:
{
    home-manager.users.${username} = _: {
	    home.file.".config/foot/foot.ini" = {
	    source = ./foot.ini;
	    recursive = true;
	};
    	home.packages = with pkgs; [ foot ];
    };
}
