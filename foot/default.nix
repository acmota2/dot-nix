{ home-manager, username, pkgs, ...}:
{
    home-manager.users.${username} = _: {
    	home.file.".config/foot" = {
	    source = "./.";
	    recursive = true;
	};
    	home.packages = with pkgs; [ foot ];
    };
}
