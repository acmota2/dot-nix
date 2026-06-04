{ config, ... }:
{
  services.getty.autologinUser = config.hostSettings.users.default.autologin;
}
