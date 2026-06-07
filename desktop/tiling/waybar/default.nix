{
  config,
  lib,
  monitors,
  ...
}:
let
  # Shared layout configurations across both bars
  barLayout = {
    layer = "top";
    height = 30;
    spacing = 0;
    margin-top = 4;
    margin-right = 10;
    margin-left = 10;
  };
  isMultiMonitor = config.hostSettings.display.multiMonitor;
  # Modules used by both the main and secondary monitors
  sharedModules = {
    "ext/workspaces" = {
      disable-scroll = true;
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
        default = "";
      };
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
    "custom/fildem" = {
      exec = "fildem";
    };
    clock = {
      format = "{:%d %b • %H:%M}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "{:%Y-%m-%d • %H:%M}";
    };
    tray = {
      spacing = 10;
    };
  };
  modules-left =
    if config.hostSettings.display.desktop.name == "hyprland" then
      [ "hyprland/workspaces" ]
    else
      [ "ext/workspaces" ];
  # ... (your let bindings stay exactly the same)
in
{
  # --- Main Monitor Bar ---
  myBar =
    barLayout
    // {
      inherit modules-left;

      output = monitors.primary.output;
      modules-center = [
        "custom/fildem"
        "clock"
      ];
      modules-right = [
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

      # Modules exclusive to the main monitor
      "hyprland/language" = {
        format-en = "US";
        format-en-intl = "US (intl)";
        format = "{}";
        on-click = "hyprctl switchxkblayout current next";
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
    }
    // sharedModules;
}
// lib.optionalAttrs isMultiMonitor (
  builtins.listToAttrs (
    map (m: {
      name = "bar-${m.output}";
      value =
        barLayout
        // {
          inherit modules-left;

          output = m.output;

          modules-center = [
            "custom/fildem"
            "clock"
          ];
          modules-right = [ "tray" ];
        }
        // sharedModules;
    }) (monitors.other or [ ])
  )
)
