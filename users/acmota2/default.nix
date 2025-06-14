{ pkgs, username, ... }:
{
    users.users."acmota2" = {
        shell = pkgs.zsh;
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        description = "acmota2";
    };

    home-manager = {
	backupFileExtension = "bak";
    	users."acmota2" = _: {
        	programs.git = {
			enable = true;
			userName = "acmota2";
		    	userEmail = "acmota2@gmail.com";
		    	aliases = {
				"ga" = "git add";
		    	};
		};
        	home.file.".zshrc".source = ./.zshrc;
	};
    };
}
