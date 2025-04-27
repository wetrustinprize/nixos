{
  self,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.lib.formats.rasi) mkLiteral;
  color = config.colorScheme.palette;
in
{
  home.packages = with pkgs; [
    bemoji
  ];

  home.file.".local/share/rofi/themes/shared/colors.rasi" = {
    text = self.lib.nixColorsReplace {
      scheme = config.colorScheme;
      text = lib.readFile ./colors.rasi;
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "CodeNewRoman Nerd Font Propo 10";
    theme = ./theme.rasi;
  };

  wayland.windowManager.hyprland.settings.bind = [
    "$mod, P, exec, rofi -show drun"
    "$mod SHIFT, P, exec, rofi -show run"

    "$mod, E, exec, bemoji"
    "$mod, W, exec, rofi -show window"

    "$mod, V, exec, cliphist list | rofi -dmenu -p  | cliphist decode | wl-copy"
  ];
}
