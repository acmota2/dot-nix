{ pkgs, hyprland, home-manager, username, nvidia, ... }:
{
    fonts.packages = with pkgs; [
        noto-fonts
            noto-fonts-emoji
            fira-code
            fira-code-symbols
            font-awesome
            nerdfonts
    ];

    environment.systemPackages = with pkgs; [ 
        grimblast
        hyprpaper
        waybar
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        xwayland
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
                name = "Bibata-Modern-Classic";
                size = 16;
            }; 

            sessionVariables = let 
                nvidium = {
                    "GBM_BACKEND" = "nvidia-drm";
                    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
                    "ENABLE_VKBASALT" = "1";
                    "LIBVA_DRIVER_NAME" = "nvidia";
                    "XDG_SESSION_TYPE" = "wayland";
                    "XDG_CURRENT_DESKTOP" = "Hyprland";
                    "WLR_NO_HARDWARE_CURSORS" = "1";
                    "WLR_RENDERER_ALLOW_SOFTWARE" = "1";
                };
                general = {
                    "NIXOS_OZONE_WL" = "1";
                };
                in if nvidia then 
                    builtins.zipAttrsWith ( name: values: builtins.head values ) [ nvidium general ] 
                else
                    general;
        };

        # hyprland
        wayland.windowManager.hyprland = { 
            extraConfig = builtins.readFile ./hypr/hyprland.conf;
        };
        
    };
}
