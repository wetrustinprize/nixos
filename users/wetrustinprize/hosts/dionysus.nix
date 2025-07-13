{
  lib,
  self,
  config,
  pkgs,
  ...
}:
let
  mkWallpaper = import ../../../utils/mkWallpaper.nix {
    inherit lib;
    inherit pkgs;
  };
  mainWallpaper = mkWallpaper {
    width = 1920;
    height = 1080;
    scheme = config.colorScheme;
  };
in
{
  require = [ ../desktop.nix ];

  programs.waybar.settings.mainBar.output = [ "eDP-1" ];

  programs.waybar.settings.modules-right = [
    "tray"
    "pulseaudio"
    "battery"
    "custom/notification"
  ];

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1, highres@highrr, 0x0, 1"
    ", preferred, auto, 1, mirror, eDP-1"
  ];

  wayland.windowManager.hyprland.settings.workspace = [
    "special:calculator, monitor:eDP-1"
    "special:obsidian, monitor:eDP-1"
    "special:password, monitor:eDP-1"
  ] ++ lib.map (i: "${toString i}, monitor:eDP-1") (lib.range 1 9);

  services.hyprpaper.settings = {
    preload = [ "${mainWallpaper}" ];
    wallpaper = [ "eDP-1, ${mainWallpaper}" ];
  };

  wayland.windowManager.hyprland.settings.input = {
    kb_layout = "br";
  };

  home.packages = with pkgs; [
    # gaming
    steam

    # game development
    godot_4

    # painting, ui/ux
    krita
  ];
}
