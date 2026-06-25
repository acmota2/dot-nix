{ lib, ... }:
let
  constants = import ./constants.nix;
in
{
  options = {
    hostSettings = {
      enable = lib.mkEnableOption "My custom host settings" // {
        default = true;
      };

      display = {
        hdr = lib.mkEnableOption "Whether a host supports or not HDR";
        multiMonitor = lib.mkEnableOption "Whether a host has or not more than one monitor by default";
        adapter = {
          enable = lib.mkEnableOption "Enable display adapter";
          manufacturer = lib.mkOption {
            description = "The display adapter's manufacturer for a given host";
            type = lib.types.enum [
              "amd"
              "intel"
              "nvidia"
            ];
          };
        };
        desktop = {
          enable = lib.mkEnableOption "Enable desktop for this host";
          name = lib.mkOption {
            default = "niri";
            description = "The compositor/DE/WM of choice for the host";
            type = lib.types.enum constants.desktops;
          };
          noctalia.enable = lib.mkEnableOption "Enable Noctalia shell";
        };
      };

      hardware = {
        enableBluetooth = lib.mkEnableOption "Enable bluetooth";
        enableNfs = lib.mkEnableOption "Enable NFS";
        enableRollingKernel = lib.mkEnableOption "Enable rolling kernel";
        isLaptop = lib.mkEnableOption "Define this host as a laptop";
        resumeDeviceUuid = lib.mkOption {
          description = "The UUID of the swap drive";
          type = lib.types.str;
          default = "";
        };
      };

      meta = {
        isWsl = lib.mkEnableOption "Declares this as a WSL host";
      };

      system.enableNixLd = lib.mkEnableOption "Enable nix-ld for pre-compiled binaries";

      users = {
        default = {
          enable = lib.mkEnableOption "My default user" // {
            default = true;
          };
          description = lib.mkOption {
            default = "André Mota";
            description = "The user's description";
            type = lib.types.str;
          };
          autologin = lib.mkEnableOption "Enable auto login for default user";
          gitEmail = lib.mkOption {
            default = "acmota2@gmail.com";
            description = "The git email for the default user";
            type = lib.types.str;
          };
          gitUser = lib.mkOption {
            default = "acmota2";
            description = "The git user for the default user";
            type = lib.types.str;
          };
          shell = lib.mkOption {
            default = "bash";
            description = "The shell of the default user";
            type = lib.types.str;
          };
          username = lib.mkOption {
            default = "acmota2";
            description = "The default username";
            type = lib.types.str;
          };
        };
        enableRootSsh = lib.mkEnableOption "Allow external hosts to have root access through ssh";
        extraUsers = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "The list of users to create in the host";
        };
      };
    };
  };
}
