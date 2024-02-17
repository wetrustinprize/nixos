{ ... }: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "none";
        geometry = "300x60-20+48";
        indicate_hidden = true;
        shrink = false;
        separator_height = 0;
        padding = 16;
        horizontal_padding = 32;
        frame_width = 2;
        sort = false;
        idle_threshold = 0;
        font = "Jetbrains 18";
        line_height = 4;
        markup = "full";
        format = "%s\\n%b";
        alignment = "left";
        show_age_threshold = 60;
        word_wrap = true;
        ignore_newline = false;
        stack_duplicates = false;
        hide_duplicate_count = true;
        show_indicators = false;
        icon_position = "left";
        sticky_history = true;
        history_length = 20;
        browser = "/usr/bin/vivaldi-stable";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
      };

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };

      urgency_low = {
        timeout = 4;
        background = "#2E3440";
        foreground = "#eceff4";
        frame_color = "#A3BE8C";
        highlight = "#A3BE8C";
      };

      urgency_normal = {
        timeout = 8;
        background = "#2E3440";
        foreground = "#eceff4";
        frame_color = "#8FBCBB";
        highlight = "#8FBCBB";
      };

      urgency_critical = {
        timeout = 0;
        background = "#2E3440";
        foreground = "#eceff4";
        frame_color = "#BF616A";
        highlight = "#BF616A";
      };
    };
  };
}
