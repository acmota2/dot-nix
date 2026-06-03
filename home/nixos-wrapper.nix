{ config, ... }:
{
  home-manager.users.${config.hostSettings.users.default.username} = _: {
    imports = [ ./home/home-manager-modules ];
  };
}
