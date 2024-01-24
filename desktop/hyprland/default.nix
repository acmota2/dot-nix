{ pkgs, hyprland, home-manager, username, nvidia, ... }:
{
    environment.systemPackages = with pkgs; [ waybar ];
    fonts.packages = with pkgs; [
        noto-fonts
            noto-fonts-emoji
            fira-code
            fira-code-symbols
            font-awesome
            nerdfonts
    ];

    home-manager.users.${username} = _: {
        imports = [ 
            hyprland.homeManagerModules.default
        ];

# waybar
        programs.waybar = if nvidia then {
            enable = true;
            nvidiaPatches = true;
        } else {
            enable = true;
        };
        home.file = {
            ".config/waybar" = {
                source = ./waybar;
                recursive = true;
            };
            ".config/hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
            ".zprofile".source = ./.zprofile;
        };

# hyprland
        home.packages = with pkgs; [ hyprpaper grimblast ];
        wayland.windowManager.hyprland = { 
            enable = true;
            extraConfig = builtins.readFile ./hypr/hyprland.conf;
        };

        home.pointerCursor = {
            gtk.enable = true;
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Classic";
            size = 16;
        }; 

    };
}
