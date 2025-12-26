{ pkgs, lib, ... }:
{
  imports = [
    ../../home
  ];

  home.file.".cache/noctalia/wallpapers.json" = {
    force = true;
    text = builtins.toJSON {
      defaultWallpaper = builtins.toString ../../home/wallpaper/main.png;
    };
  };

  programs.noctalia-shell.settings = {
    bar = {
      widgets = {
        right = lib.mkAfter [
          {
            id = "Battery";
          }
          {
            id = "Brightness";
          }
          {
            id = "WiFi";
          }
          {
            id = "Bluetooth";
          }
        ];
      };
    };
  };
}
