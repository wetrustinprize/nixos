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

  home.packages = with pkgs; [
    # work
    slack
    clickup

    # development
    gitkraken
    gemini-cli

    # game development
    godot_4
    blender

    # painting, ui/ux
    inkscape
    gimp

    # gaming
    steam
  ];

  programs.waybar.settings.mainBar = {
    output = [ "eDP-1" ];
    modules-left = lib.mkAfter [
      "cpu"
      "memory"
      "battery"
    ];
    battery = {
      bat = lib.mkForce "BAT0";
    };
  };

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, highres@highrr, 0x0, 1.25"
      ", preferred, auto, 1, mirror, eDP-1"
    ];
    input = {
      kb_layout = "br";
      kb_variant = "thinkpad";
    };
  };

  services.hyprpaper.settings = {
    preload = [
      "${mainWallpaper}"
    ];
    wallpaper = [
      "eDP-1, ${mainWallpaper}"
    ];
  };
}
