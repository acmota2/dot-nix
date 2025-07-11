{
  background = [
    {
      monitor = "";
      path = "~/pictures/dawn2.jpg";
      color = "rgba(25, 20, 20, 1.0)";
      blur_passes = 2;
    }
  ];

  label = [
    {
      monitor = "";
      text = "Authenticating $USER";
      color = "rgba(200, 200, 200, 1.0)";
      font_size = 12;
      font_family = "JetBrainsMono";

      position = "-10, 10";
      halign = "right";
      valign = "bottom";
    }

    {
      monitor = "";
      text = "$TIME";
      font_family = "JetBrainsMono:Bold";
      font_size = 150;

      position = "0, 0";
      halign = "center";
      valign = "center";
    }
  ];

  input-field = [
    {
      monitor = "";
      size = "250, 40";
      outline_thickness = 3;

      outer_color = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      check_color = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
      fail_color = "rgba(ff6633ee) rgba(ff0066ee) 40deg";

      font_family = "JetBrainsMono";
      font_size = 12;
      font_color = "rgb(0, 0, 0)";
      rounding = -1;

      position = "0, -150";
      halign = "center";
      valign = "center";
    }
  ];
}
