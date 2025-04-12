{
  pkgs,
  lib,
  self,
  config,
  ...
}:
let
  modules = import ./modules.nix { inherit lib; };
in
{
  programs.waybar = {
    enable = true;
    style = self.lib.nixColorsToGtkCss config.colorScheme + lib.readFile ./style.css;
    settings = {
      mainBar = lib.recursiveUpdate {
        layer = "bottom";
        position = "top";
        reload_style_on_change = true;
        modules-left = [
          "clock"
          "custom/pkgs"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "tray"
          "pulseaudio"
          "custom/notification"
        ];
      } modules;
    };
  };
}
