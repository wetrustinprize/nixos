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

  home.packages = with pkgs; [
    # gaming
    lutris
    steam
    prismlauncher
    steam-run
    gamemode
    gamescope
    protonup
    osu-lazer
    parsec-bin

    # work
    slack
    clickup

    # development
    gitkraken
    bruno
    bruno-cli
    filezilla
    dbeaver-bin
    aseprite
    android-studio
    ngrok
    gemini-cli
    lmstudio

    # game development
    godot_4
    unityhub

    # modeling
    blender
    material-maker

    # audio
    audacity
    reaper

    # video
    davinci-resolve

    # graphics
    krita
    inkscape
    pureref
  ];

  programs.waybar.settings = {
    mainBar.output = [ "DP-1" ];
    statusBar = lib.recursiveUpdate {
      layer = "bottom";
      position = "top";
      reload_style_on_change = true;
      output = [
        "DP-2"
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
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = lib.mkAfter [
      "[workspace name:side-monitor] discord"
    ];
    monitor = [
      "DP-1, highres@highrr, 1080x0, 1"
      "DP-2, highres@highrr, 0x-540, 1, transform, 1"
      ", preferred, auto, 1, mirror, DP-1"
    ];
    input = {
      kb_layout = "us";
      kb_variant = "altgr-intl";
    };
    workspace = lib.mkAfter [
      "name:side-monitor, monitor:DP-2"
    ];
    windowrulev2 = lib.mkAfter [
      "workspace name:side-monitor,class:(discord)"
    ];
  };

  services.hyprpaper.settings = {
    preload = [
      "${sideWallpaper}"
      "${mainWallpaper}"
    ];
    wallpaper = [
      "DP-1, ${mainWallpaper}"
      "DP-2, ${sideWallpaper}"
    ];
  };
}
