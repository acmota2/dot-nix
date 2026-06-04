let
  tilingWindowManagers = [
    "hyprland"
    "mangowc"
    "niri"
  ];
in
{
  desktops = tilingWindowManagers ++ [ "gamescope" ];
  tilingWm = tilingWindowManagers;
  utils = {
    isTiling = wm: builtins.elem wm tilingWindowManagers;
  };
}
