{ pkgs, home-manager, username, ... }:
{
	home-manager.users.${username} = _: { 
		home.file.".config/macchina/config" = {
			source = ./config;
			recursive = true;
		};
		home.packages = with pkgs; [ macchina ];
	};
}
