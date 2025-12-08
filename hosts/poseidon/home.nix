{ pkgs, ... }:
let
  waybarModules = import ../../home/waybar/modules.nix { lib = pkgs.lib; };
in
{
  imports = [
    ../../home
  ];

  programs.waybar.settings = {
    mainBar.output = [ "DP-3" ];
    statusBar = pkgs.lib.recursiveUpdate {
      layer = "bottom";
      position = "top";
      reload_style_on_change = true;
      output = [
        "DP-4"
      ];
      modules-left = [
        "bluetooth"
        "cpu"
        "memory"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "network"
      ];
    } waybarModules;
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = pkgs.lib.mkAfter [
      "[workspace name:side-monitor] discord"
    ];
    workspace =
        pkgs.lib.map (i: "${toString i}, monitor:DP-3") (pkgs.lib.range 1 9)
        ++
        ["name:side-monitor, monitor:DP-4"];
    monitor = [
      "DP-3, highres@highrr, 1080x0, 1"
      "DP-4, highres@highrr, 0x-540, 1, transform, 1"
      ", preferred, auto, 1, mirror, DP-3"
    ];
    input = {
      kb_layout = "us";
      kb_variant = "altgr-intl";
    };
    windowrulev2 = pkgs.lib.mkAfter [
      "workspace name:side-monitor,class:(discord)"
    ];
  };
}
