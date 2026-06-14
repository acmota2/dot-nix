{ actualMonitors, ... }:
{
  splash = false;
  preload = [ "~/pictures/sameiro-cold.jpg" ];
  wallpaper = map (m: {
    monitor = m.output;
    path = "~/pictures/sameiro-cold.jpg";
  }) actualMonitors;
}
