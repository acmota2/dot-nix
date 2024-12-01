{ home-manager, username, ... }:
{
    home-manager.users.${username} = _: {
        programs.kitty = {
            enable = true;
            settings = {
                font_family = "monospace";
                bold_font = "auto";
                italic_font = "auto";
                bold_italic_font = "auto";
 
                cursor_shape = "block";
               
                confirm_os_window_close = 0;
            };
        };
    };
}
