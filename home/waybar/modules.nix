{ lib, ... }:
{
  "hyprland/workspaces" = {
    format = "{name}";
    format-icons = {
      active = "";
      default = "";
      empty = "";
    };
    persistent-workspaces = {
      "*" = lib.range 1 9;
    };
  };

  battery = {
    bat = "BAT1";
    interval = 60;
    state = {
      warning = 30;
      critical = 15;
    };
    format = "{icon} {capacity}%";
    format-icons = [
      ""
      ""
      ""
      ""
      ""
    ];
  };

  clock = {
    format = "{:%I:%M:%S %p}";
    interval = 1;
    tooltip-format = "<tt>{calendar}</tt>";
    calendar = {
      format = {
        today = "<span color='#fAfBfC'><b>{}</b></span>";
      };
    };
    actions = {
      "on-click-right" = "shift_down";
      "on-click" = "shift_up";
    };
  };

  pulseaudio = {
    format = "{icon} {volume}%";
    format-muted = "󰝟";
    format-icons = {
      headphone = "󰋋";
      default = [
        ""
        ""
      ];
    };
    "on-click" = "pavucontrol";
  };

  network = {
    "format-wifi" = " {ipaddr}";
    "format-ethernet" = " {ipaddr}";
    "format-disconnected" = "";
    "tooltip-format-disconnected" = "Error";
    "tooltip-format-wifi" = "{essid} ({signalStrength}%) ";
    "tooltip-format-ethernet" = "{ifname} 🖧 ";
    "on-click" = "kitty nmtui";
  };

  bluetooth = {
    "format-on" = "󰂯";
    "format-off" = "BT-off";
    "format-disabled" = "󰂲";
    "format-connected-battery" = "{device_battery_percentage}% 󰂯";
    "format-alt" = "{device_alias} 󰂯";
    "tooltip-format" = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
    "tooltip-format-connected" =
      "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
    "tooltip-format-enumerate-connected" = "{device_alias}\n{device_address}";
    "tooltip-format-enumerate-connected-battery" =
      "{device_alias}\n{device_address}\n{device_battery_percentage}%";
    "on-click-right" = "blueman-manager";
  };

  cpu = {
    format = "󰻠 {usage}%";
  };

  memory = {
    format = " {percentage}%";
    tooltip-format = "{used:0.1f} / {total:0.1f} GB";
  };

  tray = {
    "icon-size" = 14;
    spacing = 10;
    reverse-direction = true;
  };
}
