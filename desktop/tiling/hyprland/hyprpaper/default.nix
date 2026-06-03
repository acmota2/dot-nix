{ monitors, ... }:
{
  splash = false;
  preload = [ "~/pictures/penide-cold.jpg" ];
  wallpaper = map (m: {
    monitor = m.output;
    path = "~/pictures/penide-cold.jpg";
  }) monitors;
}
