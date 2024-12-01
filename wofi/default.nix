{ home-manager, username, pkgs, ... }:
{
    home-manager.users.${username} = _: {
        home.file.".config/wofi" = {
            source = ./.;
	    recursive = true;
	};
	home.packages = with pkgs; [ wofi ];
    };
}
