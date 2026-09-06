{
  config,
  lib,
  noctalia,
  ...
}:
let
  username = config.hostSettings.users.default.username;
  wallpaper = "/home/${username}/pictures/sameiro-cold.jpg";

  paletteSpec = {
    mSurface = "#171217";
    mSurfaceVariant = "#21282d";
    mPrimary = "#8a008a";
    mSecondary = "#64727d";
    mTertiary = "#00ffff";
    mOnSurface = "#e2dee2";
    mOnSurfaceVariant = "#ffffff";
    mOnPrimary = "#ffffff";
    mOnSecondary = "#ffffff";
    mOnTertiary = "#111111";
    mOnHover = "#8a008a";
    mHover = "#2b212b";
    mError = "#eb4d4b";
    mOnError = "#111111";
    mOutline = "#8a008a";
    mShadow = "#000000";
  };
in
{
  config = lib.mkIf config.hostSettings.display.desktop.noctalia.enable {
    services.upower.enable = true;

    home-manager.users.${username} = {
      imports = [ noctalia.homeModules.default ];

      # Custom Palette file for Noctalia v5
      home.file.".config/noctalia/palettes/CGA.json".text = builtins.toJSON (
        paletteSpec // { dark = paletteSpec; }
      );

      programs.noctalia = {
        enable = true;

        settings = {
          theme = {
            mode = "dark";
            source = "wallpaper";
            # palette = "CGA";
            # custom_palette = "CGA";
          };

          dock.enabled = false;

          idle = {
            enabled = true;
            behavior = {
              screen_off = {
                enabled = true;
                timeout = 300;
              };
              suspend = {
                action = "lock_and_suspend";
                timeout = 1800;
              };
            };
          };

          bar = {
            order = [ "main" ];

            default = {
              position = "top";
              enabled = true;
              background_opacity = 0.65;
              border_width = 0.0;
              capsule = false;
              margin_edge = 0;
              margin_ends = 0;
              thickness = 34;
              radius = 0;
              concave_edge_corners = false;

              start = [
                "cpu-graph"
                "temp"
                "disk"
                "ram"
                "gpu_temp"
                "gpu_vram"
                "battery"
              ];
              center = [
                "workspaces"
                "wallpaper"
              ];
              end = [
                "volume"
                "network"
                "bluetooth"
                "clock"
                "tray"
              ];
            };
          };

          widget = {
            cpu-graph = {
              type = "sysmon";
              stat = "cpu_usage";
              visualization = "graph";
              show_value = false;
            };
            temp = {
              type = "sysmon";
              stat = "cpu_temp";
            };
            disk = {
              type = "sysmon";
              stat = "disk_used_pct";
              path = "/";
            };
            ram = {
              type = "sysmon";
              stat = "ram_used";
            };
            gpu_temp = {
              type = "sysmon";
              stat = "gpu_temp";
            };
            gpu_vram = {
              type = "sysmon";
              stat = "gpu_vram";
            };
            battery = {
              always_show_percentage = true;
            };
          };

          shell = {
            avatar_path = "/home/${username}/.face";
            font_family = "JetBrainsMono Nerd Font Propo";

            screen_corners = {
              enabled = false;
            };

            panel = {
              transparency_mode = "soft";
              control_center_placement = "attached";
              wallpaper_placement = "attached";
              session_placement = "attached";
              launcher_placement = "attached";
              clipboard_placement = "attached";
            };
          };

          location.address = "Stuttgart, Germany";

          wallpaper = {
            enabled = true;
            default.path = wallpaper;
            directory = "/home/${username}/pictures";
            fill_color = "#000000";
            solid_color = "#1a1a2e";
          };
        };
      };
    };
  };
}
