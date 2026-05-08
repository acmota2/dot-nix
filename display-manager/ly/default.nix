{
  username,
  ...
}@inputs:
let
  autoLogin = inputs.autoLogin or false;
  autoLoginSettings =
    if autoLogin then
      {
        auto_login = true;
        auto_login_user = username;
      }
    else
      { };
in
{
  security.pam.services.ly = { };
  services = {
    xserver.enable = false;
    displayManager.ly = {
      enable = true;
      settings = {
        bg = 0;
        animation = "colormix";
        colormix_col1 = "0x082E3E5A";
        colormix_col2 = "0x08356b70";
        colormix_col3 = "0x0833691E";
        fg = "0x082E3E5A";
        hide_borders = true;
        hide_version_string = true;
        logout_cmd = "clear && reset && chvt 1";
        numlock = false;
        save = true;
        vi_mode = false;
      }
      // autoLoginSettings;
    };
  };
  systemd.services."getty@tty1".enable = false;
}
