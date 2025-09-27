{
  isHomeManager,
  walker,
  ...
}:
{
  imports =
    if isHomeManager then [ walker.homeManagerModules.default ] else [ walker.nixosModules.default ];
  programs.walker = {
    enable = true;
    runAsService = true;
    # All options from the config.toml can be used here.
    config = {
      force_keyboard_focus = true;
      close_when_open = true;
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
            time_format = "%d.%m. - %H:%M";
            default = "copy";
            copy = "Return";
            delete = "ctrl d";
            edit = "ctrl o";
            toggle_images_only = "ctrl i";
          }
        ];
      };
    };

    theme.style = builtins.readFile ./style.css;
  };
}
