{ pkgs, home-manager, username, ... }:
{
    # environment.systemPackages = with pkgs; [ swaylock ];
    home-manager.users.${username} = _: {
        home = {
            packages = with pkgs; [ swaylock-effects ];
            file."./.config/swaylock/swaylock.conf".source = ./swaylock.conf;
        };
    };
    security.pam.services.swaylock = {
        text = ''
        auth include login
        '';
    };

}
