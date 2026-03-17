{
  myBar = {
    layer = "top";
    height = 30;
    spacing = 0;
    margin-top = 4;
    margin-right = 10;
    margin-left = 10;
    modules-left = [ "hyprland/workspaces" ];
    modules-center = [
      "custom/fildem"
      "clock"
    ];
    modules-right = [
      "hyprland/language"
      "pulseaudio"
      "network"
      "cpu"
      "temperature"
      "memory"
      "backlight"
      "battery"
      "battery#bat2"
      "tray"
    ];
    # Modules configuration
    "hyprland/language" = {
      format-en = "US";
      format-en-intl = "US (intl)";
      format = "{}";
      on-click = "hyprctl switchxkblayout current next";
    };
    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      warp-on-scroll = false;
      format = "{icon}";
      format-icons = {
        "1" = " ";
        "2" = " ";
        "3" = " ";
        "4" = " ";
        "5" = "󱎓";
        "6" = " 6 ";
        "7" = " 7 ";
        "8" = " 8 ";
        "9" = " 9 ";
        urgent = "";
        focused = "";
        default = "";
      };
    };
    keyboard-state = {
      numlock = true;
      capslock = true;
      format = "{name} {icon}";
      format-icons = {
        locked = "";
        unlocked = "";
      };
    };
    "sway/mode" = {
      format = "<span style=\"italic\">{}</span>";
    };
    "sway/scratchpad" = {
      format = "{icon} {count}";
      show-empty = false;
      format-icons = [
        ""
        ""
      ];
      tooltip = true;
      tooltip-format = "{app}: {title}";
    };
    mpd = {
      format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
      format-disconnected = "Disconnected ";
      format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
      unknown-tag = "N/A";
      interval = 2;
      consume-icons = {
        on = " ";
      };
      random-icons = {
        off = "<span color=\"#f53c3c\"></span> ";
        on = " ";
      };
      repeat-icons = {
        on = " ";
      };
      single-icons = {
        on = "1 ";
      };
      state-icons = {
        paused = "";
        playing = "";
      };
      tooltip-format = "MPD (connected)";
      tooltip-format-disconnected = "MPD (disconnected)";
    };
    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
    };
    tray = {
      # "icon-size"= 21;
      spacing = 10;
    };
    clock = {
      # "timezone"= "America/New_York";
      format = "{:%d %b • %H:%M}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "{:%Y-%m-%d • %H:%M}";
    };
    cpu = {
      format = "{usage}% ";
      tooltip = false;
    };
    memory = {
      format = "{}% ";
    };
    temperature = {
      thermal-zone = 2;
      hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
      # "hwmon-path"= "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon2/temp1_input";
      critical-threshold = 80;
      # "format-critical"= "{temperatureC}°C {icon}";
      format = "{temperatureC}°C {icon}";
      format-icons = [
        ""
        ""
        ""
      ];
    };
    backlight = {
      # "device"= "acpi_video1";
      format = "{percent}% {icon}";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
      ];
    };
    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{capacity}% {icon}";
      format-charging = "{capacity}% ";
      format-plugged = "{capacity}% ";
      format-alt = "{time} {capacity}% {icon}";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
    };
    "battery#bat2" = {
      bat = "BAT2";
    };
    network = {
      format-wifi = "[{signalStrength}%] ";
      format-ethernet = "󰛳";
      tooltip-format = "[ {ifname} ] {essid} 󰲝";
      format-linked = "󰱓";
      format-disconnected = "󰅛";
    };
    pulseaudio = {
      format = "{volume}% {icon}";
      format-bluetooth = "{volume}% {icon}";
      format-bluetooth-muted = "󰝟 {icon}";
      format-muted = "󰝟";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [
          ""
          ""
          ""
        ];
      };
      on-click = "pavucontrol";
    };
    "custom/media" = {
      format = "{icon} {}";
      return-type = "json";
      max-length = 40;
      format-icons = {
        spotify = "";
        default = "🎜";
      };
      escape = true;
      exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
    };
    "custom/fildem" = {
      exec = "fildem";
    };
  };
}
