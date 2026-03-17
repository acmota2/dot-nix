{
  pkgs,
  username,
  monitors,
  ...
}@inputs:
let
  renderMonitor =
    m:
    let
      base = [
        "name:^${m.output}$"
        "width:${toString m.width}"
        "height:${toString m.height}"
        "refresh:${toString m.refresh}"
        "x:${toString m.x}"
        "y:${toString m.y}"
        "scale:${toString m.scale}"
        "vrr:${toString m.vrr}"
        "rr:${toString m.rotate}"
      ];
    in
    "monitorrule=" + builtins.concatStringsSep "," base;

  monitorLines = builtins.concatStringsSep "\n" (map renderMonitor monitors);

  mangoConfig =
    builtins.readFile ./mangowc.conf
    + "\n\n"
    + monitorLines
    + "\n\n"
    + "exec-once=~/.config/mango/autostart.sh\n";
in
{
  imports = [
    inputs.mango.nixosModules.mango
  ];

  environment.systemPackages = with pkgs; [
    swaybg
    swayidle
    swaylock-effects
    grim
    slurp
  ];

  services.dbus.enable = true;

  programs.mango.enable = true;

  security.pam.services.swaylock = { };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  home-manager.users.${username} = _: {
    imports = [
      inputs.mango.hmModules.mango
    ];

    wayland.windowManager.mango = {
      enable = true;
      settings = mangoConfig;
      autostart_sh = builtins.readFile ./autostart.sh;
    };

    home.file.".config/swaylock/config".source = ./swaylock.conf;
  };
}
