{
  config,
  noctalia,
  ...
}:
{
  services.upower.enable = true;

  home-manager.users.${config.hostSettings.users.default.username} = {
    imports = [ noctalia.homeModules.default ];

    programs.noctalia-shell = {
      enable = true;
    };
    settings = {
      bar = {
        position = "top";
        density = "default";
        showCapsule = true;

        widgets = {
          left = [
            {
              id = "SystemMonitor";
              displayMode = "compact";
            }
            { id = "Audio"; }
            {
              id = "Battery";
              alwaysShowPercentage = false;
            }
          ];

          center = [
            {
              id = "Workspace";
              labelMode = "none";
            }
            { id = "WallpaperPicker"; }
          ];

          right = [
            {
              id = "Clock";
              useMonospacedFont = true;
            }
            { id = "Systray"; }
          ];
        };
      };
    };
  };
}
