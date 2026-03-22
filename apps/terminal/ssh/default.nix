{
  defaultUser,
  extraUsers ? { },
  pkgs,
  ...
}:
let
  users = extraUsers // defaultUser;
in
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = pkgs.lib.attrNames users;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
