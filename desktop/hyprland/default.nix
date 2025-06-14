{ pkgs, hyprland, home-manager, username, ... }:
{
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-emoji
        jetbrains-mono
        font-awesome
	nerd-fonts.jetbrains-mono
    ];

    environment.systemPackages = with pkgs; [
        grimblast
        hyprpaper
        hypridle
        hyprlock
        waybar
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        xwayland
        wl-clipboard-rs
        wofi-emoji
        cliphist
    ];

    services.dbus.enable = true;
    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [
            pkgs.xdg-desktop-portal-gtk
        ];
    };

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    home-manager.users.${username} = _: {
        imports = [ 
            hyprland.homeManagerModules.default
        ];

        programs.waybar.enable = true;
        home = {
            file = {
                # waybar cfg
                ".config/waybar" = {
                    source = ./waybar;
                    recursive = true;
                };
                # hyrpaper config
                ".config/hypr" = {
                    source = ./hypr;
                    recursive = true;
                };
                # session start
                ".zprofile".source = ./.zprofile;
            };

            pointerCursor = {
                gtk.enable = true;
                package = pkgs.bibata-cursors;
                name = "Bibata-Modern-Ice";
                size = 16;
            }; 

            sessionVariables = {
                "NIXOS_OZONE_WL" = "1";
            };
        };

        # hyprland
        wayland.windowManager.hyprland = { 
            extraConfig = builtins.readFile ./hypr/hyprland.conf;
        };
        
    };
}
