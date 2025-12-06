{ pkgs, ... }:
let
  modules = import ./modules.nix { lib = pkgs.lib; };
in
{
  home.packages = with pkgs; [
    waybar
  ];

  stylix.targets.waybar.addCss = false;

  programs.waybar = {
    enable = true;
    style = pkgs.lib.readFile ./style.css;
    settings = {
      mainBar = pkgs.lib.recursiveUpdate {
        layer = "bottom";
        position = "top";
        reload_style_on_change = true;
        modules-left = [
          "clock"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "tray"
          "pulseaudio"
        ];
      } modules;
    };
  };
}
