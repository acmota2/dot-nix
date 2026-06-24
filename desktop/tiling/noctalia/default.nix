{
  config,
  lib,
  monitors,
  noctalia,
  ...
}:
let
  suspendCommand = "systemctl suspend";
in
{
  config = lib.mkIf config.hostSettings.display.desktop.noctalia.enable {
    services.upower.enable = true;

    home-manager.users.${config.hostSettings.users.default.username} = {
      imports = [ noctalia.homeModules.default ];

      home.file.".cache/noctalia/wallpapers.json" =
        let
          wallpaper = "/home/${config.hostSettings.users.default.username}/pictures/sameiro-cold.jpg";
        in
        {
          text = builtins.toJSON {
            defaultWallpaper = wallpaper;
            wallpapers = {
              ${monitors.primary.output} = wallpaper;
            };
          };
        };

      programs.noctalia-shell = {
        enable = true;

        colors = {
          mSurface = "#171217";
          mSurfaceVariant = "#21282d";

          # Your original accent keys
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

        settings = {
          colorSchemes = {
            darkMode = true;
            useWallpaperColors = false;
          };

          dock.enabled = false;

          idle = {
            inherit suspendCommand;
            enabled = true;
            screenOffTimeout = 300;
            lockTimeout = 0;
            suspendTimeout = 1800;
          };

          powerOptions = [
            {
              action = "suspend";
              command = suspendCommand;
              countdownEnabled = true;
              enabled = true;
              keybind = "2";
            }
          ];

          bar = {
            backgroundOpacity = 0.65;
            useSeparateOpacity = true;
            showOutline = false;
            showCapsule = false;
            outerCorners = false;
            marginVertical = 4;
            marginHorizontal = 4;
            frameThickness = 8;
            frameRadius = 12;

            widgets = {
              left = [
                {
                  id = "SystemMonitor";
                  iconColor = "tertiary";
                  showCpuFreq = true;
                  showDiskUsage = true;
                  showGpuTemp = true;
                  compactMode = false;
                }
                {
                  id = "Battery";
                  alwaysShowPercentage = true;
                }
              ];
              center = [
                {
                  id = "Workspace";
                  labelMode = "none";
                }
                { id = "WallpaperSelector"; }
              ];
              right = [
                { id = "Volume"; }
                { id = "Network"; }
                { id = "Bluetooth"; }
                {
                  id = "Clock";
                  useMonospaceFont = true;
                }
                { id = "Tray"; }
              ];
            };
          };

          general = {
            avatarImage = "/home/acmota2/.face";
            clockFormat = "hh\\nmm";
            clockStyle = "custom";
            lockOnSuspend = false;
            lockScreenAnimations = false;
            showScreenCorners = false;
            showSessionButtonsOnLockScreen = true;
          };

          ui = {
            fontDefault = "JetBrainsMono Nerd Font Propo";
            fontFixed = "monospace";
            panelBackgroundOpacity = 0.65;
            panelsAttachedToBar = true;
            settingsPanelMode = "centered";
            settingsPanelSideBarCardStyle = true;
            translucentWidgets = true;
          };

          location = {
            name = "Stuttgart, Germany";
          };

          noctaliaPerformance.disableWallpaper = false;

          wallpaper = {
            enabled = true;
            directory = "/home/acmota2/pictures";
            fillColor = "#000000";
            solidColor = "#1a1a2e";
            hideWallpaperFilenames = true;
            setWallpaperOnAllMonitors = true;
          };

          systemMonitor = {
            enableDgpuMonitoring = true;
          };

        };
      };
    };
  };
}
