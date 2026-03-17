{
  myBar = {
    layer = "top";
    height = 30;
    spacing = 0;
    margin-top = 4;
    margin-right = 10;
    margin-left = 10;

    modules-left = [ "ext/workspaces" ];

    modules-center = [
      "custom/fildem"
      "clock"
    ];

    modules-right = [
      # Replaces hyprland/language. You will need a tiny script for this.
      "custom/keyboard-layout"
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

    "ext/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      format = "{icon}";
      on-click = "activate";
      sort-by-id = true;

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
        active = "";
        default = "";
      };
    };

    # MangoWC does not have the Hyprland-specific language module,
    # so use a custom script here instead.
    #
    # Suggested contract:
    # - script prints JSON, e.g. {"text":"US","tooltip":"English (US)"}
    # - on-click switches to the next configured XKB layout
    #
    # You can leave this module out entirely for the first migration pass
    # if you want to keep things simpler.
    "custom/keyboard-layout" = {
      format = "{}";
      return-type = "json";
      interval = 1;
      exec = "$HOME/.config/waybar/scripts/keyboard-layout";
      on-click = "$HOME/.config/waybar/scripts/keyboard-layout --next";
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
      spacing = 10;
    };

    clock = {
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
      critical-threshold = 80;
      format = "{temperatureC}°C {icon}";
      format-icons = [
        ""
        ""
        ""
      ];
    };

    backlight = {
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
