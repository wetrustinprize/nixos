{ pkgs, ... }:
{
  imports = [
    ../../home
  ];

  programs.niri.settings.outputs = {
    "DP-3" = {
      mode = {
        height = 1080;
        width = 1920;
        refresh = 144.001;
      };
      position = {
        x = 1920;
        y = 0;
      };
      focus-at-startup = true;
    };

    "HDMI-A-2" = {
      mode = {
        height = 1080;
        width = 1920;
        refresh = 60.0;
      };
      position = {
        x = 0;
        y = 0;
      };
    };
  };

  home.file.".cache/noctalia/wallpapers.json" = {
    force = true;
    text = builtins.toJSON {
      defaultWallpaper = builtins.toString ../../home/wallpaper/main.png;
      wallpapers = {
        "DP-3" = builtins.toString ../../home/wallpaper/main.png;
        "HDMI-A-2" = builtins.toString ../../home/wallpaper/left.png;
      };
    };
  };

  programs.noctalia-shell.settings = {
    network = {
      wifiEnabled = false;
    };
  };
}
