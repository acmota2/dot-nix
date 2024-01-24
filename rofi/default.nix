{ home-manager, username, pkgs, ... }:
{
    home-manager.users.${username} = _: {
        home.file.".config/rofi" = {
            source = ./.;
            recursive = true;
        };
    	home.packages = with pkgs; [ rofi ];
    };
}
