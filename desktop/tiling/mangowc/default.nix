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
        "width:${m.width}"
        "height:${m.height}"
        "refresh:${m.nrefresh}"
        "x:${m.x}"
        "y:${m.y}"
        "scale:${m.scale}"
        "vrr:${m.vrr}"
        "rr:${m.rr}"
      ];
    in
    "monitorrule=" + builtins.concatStringsSep "," base;

  monitorLines = builtins.concatStringsSep "\n" (map renderMonitor monitors);

  mangoConfig = builtins.readFile ./mangowc.conf + "\n\n" + monitorLines + "\n";
in
{
  imports = [
    inputs.mango.nixosModules.mango
  ];

  environment.systemPackages = with pkgs; [
    swaybg
    swayidle
    swaylock
    grim
    slurp
  ];

  services.dbus.enable = true;

  programs.mango.enable = true;

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
  };
}
