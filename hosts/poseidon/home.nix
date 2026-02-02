{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../home
  ];

  home.packages = [
    pkgs.davinci-resolve # video editing
    inputs.affinity-nix.packages.${pkgs.stdenv.system}.v3 # whole image editing suite
  ];

  programs.obs-studio.package = (
    pkgs.obs-studio.override {
      cudaSupport = true; # nvidia hardware accel
    }
  );

  programs.niri.settings.outputs = {
    "DP-3" = {
      mode = {
        height = 1080;
        width = 1920;
        refresh = 119.879; # having issues with the monitor, have to lower the refresh rate
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

    notifications.monitors = ["HDMI-A-2"];
  };
}
