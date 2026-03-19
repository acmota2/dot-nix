{ desktop, ... }:
let
  tiling = [
    "hyprland"
    "mangowc"
  ];
in
{
  imports =
    if builtins.elem desktop tiling then
      [
        ./tiling/${desktop}
      ]
    else
      [
        ./${desktop}
      ];
}
