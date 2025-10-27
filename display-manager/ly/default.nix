_: {
  services = {
    xserver.enable = true;
    displayManager = {
      enable = true;
      ly = {
        enable = true;
        settings = {
          # Brightness decrease command
          # brightness_down_cmd = "$PREFIX_DIRECTORY/bin/brightnessctl -q -n s 10%-";
          # Brightness decrease key, or null to disable
          # brightness_down_key = "F5";
          # Brightness increase command
          # brightness_up_cmd = "$PREFIX_DIRECTORY/bin/brightnessctl -q -n s +10%";
          # Brightness increase key, or null to disable
          # brightness_up_key = "F6";
          allow_empty_password = true;
          animate = true;
          animation = "doom";
          animation_timeout_sec = 0;
          asterisk = "*";
          auth_fails = "5";
          battery_id = "null";
          bg = "0x00000000";
          bigclock = "english";
          bigclock_12hr = false;
          bigclock_seconds = false;
          blank_box = true;
          border_fg = "0x00FFFFFF";
          box_title = "null";
          clear_password = true;
          clock = "null";
          cmatrix_fg = "0x0000FF00";
          cmatrix_head_col = "0x01FFFFFF";
          cmatrix_max_codepoint = "0x7B";
          cmatrix_min_codepoint = "0x21";
          colormix_col1 = "0x00FF0000";
          colormix_col2 = "0x000000FF";
          colormix_col3 = "0x20000000";
          custom_sessions = "";
          default_input = "login";
          doom_bottom_color = "0x00FFFFFF";
          doom_fire_height = "6";
          doom_fire_spread = 2;
          doom_middle_color = "0x00C78F17";
          doom_top_color = "0x009F2707";
          edge_margin = "0";
          error_bg = "0x00000000";
          error_fg = "0x01FF0000";
          fg = "0x00FFFFFF";
          full_color = true;
          gameoflife_entropy_interval = "10";
          gameoflife_fg = "0x0000FF00";
          gameoflife_frame_delay = "6";
          gameoflife_initial_density = "0.4";
          hide_borders = true;
          hide_key_hints = false;
          hide_version_string = false;
          initial_info_text = "null";
          input_len = "34";
          lang = "en";
          login_cmd = "null";
          login_defs_path = "null";
          logout_cmd = "null";
          ly_log = "/var/log/ly.log";
          margin_box_h = "2";
          margin_box_v = "1";
          min_refresh_delta = 5;
          numlock = false;
          save = true;
          session_log = "ly-session.log";
          setup_cmd = "null";
          sleep_cmd = "null";
          sleep_key = "F3";
          text_in_center = true;
          vi_default_mode = "normal";
          vi_mode = false;
          xinitrc = "null";
        };
      };
    };
  };
}
