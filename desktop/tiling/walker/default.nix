{ isHomeManager, walker, ... }:
{
  imports =
    if isHomeManager then [ walker.homeManagerModules.default ] else [ walker.nixosModules.default ];

  # workaround to disable current nixpkgs implementation
  disabledModules = [ "services/misc/elephant.nix" ];

  environment.systemPackages = [
    walker.packages.x86_64-linux.default
  ];

  programs.walker = {
    enable = true;

    config = {
      force_keyboard_focus = true;
      close_when_open = true;
      window_width = 900;
      window_height = 300;
      placeholders."default" = {
        input = "Search";
        list = "No results";
      };
      providers = {
        default = [
          "websearch"
          "desktopapplications"
          "calc"
          "runner"
          "menus"
          "symbols"
        ];
        empty = [ "desktopapplications" ];
        prefixes = [
          {
            provider = "websearch";
            prefix = "+";
          }
          {
            provider = "calc";
            prefix = "=";
          }
          {
            provider = "runner";
            prefix = ">";
          }
          {
            provider = "menus";
            prefix = "@";
          }
          {
            provider = "clipboard";
            prefix = ":";
            time_format = "%d.%m. - %H:%M";
            default = "copy";
            copy = "Return";
            delete = "ctrl d";
            edit = "ctrl o";
            toggle_images_only = "ctrl i";
          }
          {
            provider = "symbols";
            prefix = "&";
          }
        ];
      };
      theme = "myTheme";
    };
    themes."myTheme".style = builtins.readFile ./style.css;
  };
}
