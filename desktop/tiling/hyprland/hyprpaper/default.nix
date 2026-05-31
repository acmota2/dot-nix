{ monitors, ... }:
{
  splash = true;
  preload = [ "~/pictures/penide-cold.jpg" ];
  wallpaper = map (m: {
    monitor = m.output;
    path = "~/pictures/penide-cold.jpg";
  }) monitors;
}
