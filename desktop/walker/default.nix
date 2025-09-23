{
  isHomeManager,
  myUtils,
  username,
  walker,
  ...
}:
let
  commonAttrs = myUtils.homeOrNixos {
    inherit isHomeManager username;
    options = {
      imports = [ walker.homeManagerModules.default ];
      programs.walker = {
        enable = true;
        runAsService = true;
        /*
                # All options from the config.toml can be used here.
                config = {
                  placeholders."default".input = "Example";
                  providers.prefixes = [
                    {
                      provider = "websearch";
                      prefix = "+";
                    }
                    {
                      provider = "providerlist";
                      prefix = "_";
                    }
                  ];
                };

                theme.style = builtins.lib.readFile ./style.css;
              };
        */
      };
    };
  };
in
{
  nix.settings = {
    substituters = [ "https://walker.cachix.org" ];
    trusted-public-keys = [ "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM=" ];
  };
}
// commonAttrs
