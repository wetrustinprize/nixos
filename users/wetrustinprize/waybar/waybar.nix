{ pkgs, lib, self, config, ... }:

{
  programs.waybar = {
    enable = true;
    style =  self.lib.nixColorsToGtkCss config.colorScheme + lib.readFile ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        reload_style_on_change = true;
        output = [
          "DP-1"
        ];
        modules-left = [
          "custom/notification"
          "clock"
          "custom/pkgs"
          "tray"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
		"cpu"
		"memory"
		"temperature"
          "bluetooth"
          "network"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
            empty = "";
          };
          persistent-workspaces = {
            "*" = lib.range 1 9;
          };
        };

        "custom/notification" = {
          tooltip = false;
          format = "";
          on-click = "swaync-client -t -sw";
          escape = true;
        };

        clock = {
          format = "{:%I:%M:%S %p} ";
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

        network = {
          "format-wifi" = "";
          "format-ethernet" = "";
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

        "custom/pkgs" = {
          format = "󰅢 {}";
          interval = 30;
          exec = "echo $(( $(ls /run/current-system/sw/bin/ | wc -l) + $(ls ~/.nix-profile/bin/ | wc -l) ))";
          "exec-if" = "exit 0";
          signal = 8;
          tooltip = false;
        };

        cpu = {
          format = "󰻠";
          tooltip = true;
        };

        memory = {
          format = "";
        };

        temperature = {
          "critical-threshold" = 80;
          format = "";
        };

        tray = {
          "icon-size" = 14;
          spacing = 10;
        };
      };
    };
  };
}
