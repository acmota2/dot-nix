{ pkgs, ... }:
let
  hyprland-starter = pkgs.writeScript "hyprland-starter" ''
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_DESKTOP=Hyprland
    export QT_QPA_PLATFORM=wayland
    export SDL_VIDEODRIVER=wayland
    export MOZ_ENABLE_WAYLAND=1

    exec start-hyprland
  '';
in
{
  security.pam.services.ly = { };
  services = {
    xserver.enable = false;
    displayManager.ly = {
      enable = true;
      settings = {
        allow_empty_password = true;
        bg = 0;
        animation = "colormix";
        colormix_col1 = "0x082E3E5A";
        colormix_col2 = "0x08356b70";
        colormix_col3 = "0x0833691E";
        fg = "0x082E3E5A";
        hide_borders = true;
        hide_version_string = true;
        login_cmd = "${hyprland-starter}";
        logout_cm = "clear && reset && chvt 1";
        numlock = false;
        save = true;
        vi_mode = false;
      };
    };
  };
  systemd.services."getty@tty1".enable = false;
}
