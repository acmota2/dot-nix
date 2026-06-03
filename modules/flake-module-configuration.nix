{ lib, ... }:
{
  options.hostSettings = {
    enable = lib.mkEnableOption "My custom host settings" // {
      default = true;
    };

    display = {
      hdr = lib.mkEnableOption "Whether a host supports or not HDR";
      multiMonitor = lib.mkEnableOption "Whether a host has or not more than one monitor by default";
      adapter = {
        enable = lib.mkEnableOption "Enable display adapter";
        manufacturer = lib.mkOption {
          type = lib.types.enum [
            "amd"
            "intel"
            "nvidia"
          ];
          description = "The display adapter's manufacturer for a given host";
        };
      };
      desktop = lib.mkOption {
        type = lib.types.enum [
          "hyprland"
          "mangowc"
        ];
        default = "hyprland";
        description = "The compositor/DE/WM of choice for the host";
      };
    };

    hardware = {
      enableBluetooth = lib.mkEnableOption "Enable bluetooth";
      enableRollingKernel = lib.mkEnableOption "Enable rolling kernel";
      isLaptop = lib.mkEnableOption "Define this host as a laptop";
    };

    meta = {
      isHomeManager = lib.mkEnableOption "Whether this is a home configuration or a home-manager config";
      isWsl = lib.mkEnableOption "Declares this as a WSL host";
    };

    users = {
      acmota2 = {
        enable = lib.mkEnableOption "My default user" // {
          default = true;
        };
        gitEmail = "acmota2@gmail.com";
        gitUser = "acmota2";
        shell = "bash";
      };
      extraUsers = lib.mkOption {
        type = lib.types.listOf lib.types.string;
        default = [ ];
        description = "The list of users to create in the host";
      };
    };
  };
}
