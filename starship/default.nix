{ pkgs, home-manager, username, ... }:
{
	home-manager.users.${username} = _: { 
		home.file.".config/starship.toml" = {
			source = ./.;
			recursive = true;
		};
		home.packages = with pkgs; [ starship ];
	};
}
