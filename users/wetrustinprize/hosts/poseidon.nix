{
  lib,
  self,
  config,
  pkgs,
  ...
}:
let
  waybarModules = import ../modules/waybar/modules.nix { inherit lib; };
  mkWallpaper = import ../../../utils/mkWallpaper.nix {
    inherit lib;
    inherit pkgs;
  };
  sideWallpaper = mkWallpaper {
    width = 1080;
    height = 1920;
    scheme = config.colorScheme;
  };
  mainWallpaper = mkWallpaper {
    width = 1920;
    height = 1080;
    scheme = config.colorScheme;
  };
in
{
  require = [ ../desktop.nix ];

  programs.waybar.settings.statusBar = lib.recursiveUpdate {
    layer = "bottom";
    position = "top";
    reload_style_on_change = true;
    output = [
      "HDMI-A-1"
    ];
    modules-left = [
      "bluetooth"
      "cpu"
      "memory"
    ];
    modules-center = [ "clock" ];
    modules-right = [
      "network"
    ];
  } waybarModules;

  programs.waybar.settings.mainBar.output = [ "DP-1" ];

  wayland.windowManager.hyprland.settings.monitor = [
    "DP-1, highres@highrr, 1080x0, 1"
    "HDMI-A-1, highres@highrr, 0x-540, 1, transform, 1"
    ", preferred, auto, 1, mirror, DP-1"
  ];

  wayland.windowManager.hyprland.settings.input = {
    kb_layout = "us";
    kb_variant = "altgr-intl";
  };

  wayland.windowManager.hyprland.settings.workspace = [
    "name:side-monitor, monitor:HDMI-A-1"
    "special:calculator, monitor:DP-1"
    "special:obsidian, monitor:DP-1"
    "special:password, monitor:DP-1"
  ] ++ lib.map (i: "${toString i}, monitor:DP-1") (lib.range 1 9);

  services.hyprpaper.settings = {
    preload = [
      "${sideWallpaper}"
      "${mainWallpaper}"
    ];
    wallpaper = [
      "DP-1, ${mainWallpaper}"
      "HDMI-A-1, ${sideWallpaper}"
    ];
  };
}
