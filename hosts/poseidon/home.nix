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

  programs.niri.settings.spawn-at-startup = pkgs.lib.mkAfter [
    { sh = "swaybg -o HDMI-A-2 -i ${(builtins.toString ../../home/wallpaper/left.png)}"; }
  ];
}
