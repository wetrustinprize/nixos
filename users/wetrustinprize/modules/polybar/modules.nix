colors: {
  "module/open" = {
    type = "custom/text";
    content-background = "${colors.background}";
    content-foreground = "${colors.module}";
    content = "%{T2}%{T-}";
  };
  "module/close" = {
    type = "custom/text";
    content-background = "${colors.background}";
    content-foreground = "${colors.module}";
    content = "%{T2}%{T-}";
  };
  "module/divider" = {
    type = "custom/text";
    content-background = "${colors.background}";
    content-foreground = "${colors.disabled}";
    content-margin = 2;
    content = "%{T3}%{T-}";
  };
  "module/distro" = {
    type = "custom/text";
    content-foreground = "${colors.disabled}";
    content-margin = 1;
    content = "%{T4}󱄅%{T-}";
  };
  "module/time" = {
    type = "internal/date";
    interval = 1.0;
    time = "%I:%M %p";
    label = "%time%";
    format = " <label>";
    format-padding = 1;
    format-background = "${colors.module}";
  };
  "module/date" = {
    type = "internal/date";
    interval = 1.0;
    date = "%d/%m/%y";
    label = "%date%";
    format = " <label>";
    format-padding = 1;
    format-background = "${colors.module}";
  };
  "module/i3" = {
    type = "internal/i3";
    pin-workspaces = false;
    show-urgent = true;
    strip-wsnumbers = true;
    index-sort = true;
    enable-click = true;
    enable-scroll = false;
    label-focused = "%index%";
    label-focused-padding = 1;
    label-focused-margin = 1;
    label-focused-background = "${colors.primary}";
    label-focused-foreground = "${colors.background}";
    label-visible = "%index%";
    label-visible-padding = 1;
    label-visible-background = "${colors.background}";
    label-visible-foreground = "${colors.foreground}";
    label-visible-underline = "${colors.disabled}";
    label-unfocused = "%index%";
    label-unfocused-padding = 1;
    label-unfocused-background = "${colors.background}";
    label-unfocused-foreground = "${colors.disabled}";
    label-urgent = "%index%!";
    label-urgent-padding = 2;
    label-urgent-margin = 1;
    label-urgent-background = "${colors.danger}";
    label-urgent-foreground = "${colors.background}";
  };
  "module/memory" = {
    type = "internal/memory";
    interval = 3;
    warn-percentage = 95;
    label = "%used%";
    label-warm-color = "${colors.alert}";
    format = "󰍛 <label>";
    format-foreground = "${colors.disabled}";
  };
  "module/cpu" = {
    type = "internal/cpu";
    interval = 0.5;
    warn-percentage = 95;
    format = " <label>";
    format-foreground = "${colors.disabled}";
  };
  "module/pulseaudio" = {
    type = "internal/pulseaudio";
    use-ui-max = true;
    interval = 5;
    format-volume = "<bar-volume> <label-volume>";
    format-muted = "MUTED 󰝟";
    format-muted-foreground = "${colors.disabled}";
    bar-volume-width = 5;
    bar-volume-fill = "―";
    bar-volume-fill-foreground = "${colors.foreground}";
    bar-volume-empty = "―";
    bar-volume-empty-foreground = "${colors.disabled}";
    bar-volume-indicator = "―";
    bar-volume-indicator-foreground = "${colors.foreground}";
  };
  "module/wired-ipv4" = {
    type = "internal/network";
    interface = "eno1";
    label-connected = "󰈀 %local_ip%";
    format-connected = "<label-connected>";
    format-connected-foreground = "${colors.disabled}";
    label-disconnected = "󰈀 N/A";
    format-disconnected = "<label-disconnected>";
    format-disconnected-foreground = "${colors.disabled}";
  };
  "module/mute-mic" = {
    type = "custom/script";
    exec = "~/.config/polybar/scripts/mute-mic.sh";
    tail = true;
    click-left = "kill -USR1 %pid%";
    format-padding = 1;
  };
  "module/mute-dunst" = {
    type = "custom/script";
    exec = "~/.config/polybar/scripts/mute-dunst.sh";
    tail = true;
    click-left = "kill -USR1 %pid%";
    format-padding = 1;
  };
  "module/battery" = {
    type = "internal/battery";
    full-at = 100;
    low-at = 5;
    poll-interval = 5;
    format-charging = "<animation-charging> <label-charging>";
    format-discharging = "<ramp-capacity> <label-discharging>";
    format-full = "<label-full>";
    format-low = "<animation-low> <label-low>";
    label-charging = "%percentage%%";
    label-discharging = "%percentage%%";
    label-low = "%percentage%%";
    label-full = "󰁹 %percentage%%";
    animation-charging-0 = " ";
    animation-charging-1 = "󱐋";
    animation-charging-framerate = 1000;
    animation-low-0 = "󰂃";
    animation-low-1 = "󰂎";
    animation-low-framerate = 500;
    ramp-capacity-0 = "󰂎";
    ramp-capacity-1 = "󰁺";
    ramp-capacity-2 = "󰁻";
    ramp-capacity-3 = "󰁼";
    ramp-capacity-4 = "󰁽";
    ramp-capacity-5 = "󰁾";
    ramp-capacity-6 = "󰁿";
    ramp-capacity-7 = "󰂀";
    ramp-capacity-8 = "󰂁";
    ramp-capacity-9 = "󰂂";
  };
}
